{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      lix-module,
      home-manager,
      nixvim,
      nixos-hardware,
      stylix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      packages = import ./pkgs { inherit pkgs; };
    in
    {
      inherit packages;
      formatter.${system} = pkgs.alejandra;

      overlays = import ./overlays { inherit inputs outputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager { inherit inputs; };

      nixosConfigurations = {
        wyvern = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            # not actually super secret, just dont want it in a public repo
            secrets = import ./secrets.nix;
          };
          modules = [
            lix-module.nixosModules.default
            ./hosts/wyvern
            # inputs.flake-programs-sqlite.nixosModules.programs-sqlite
            nixos-hardware.nixosModules.framework-11th-gen-intel
          ];
        };
        dragon = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            # not actually super secret, just dont want it in a public repo
            secrets = import ./secrets.nix;
          };
          modules = [
            lix-module.nixosModules.default
            ./hosts/dragon
            # inputs.flake-programs-sqlite.nixosModules.programs-sqlite
          ];
        };
      };

      homeConfigurations = {
        "avery_the_dragon@wyvern" = lib.homeManagerConfiguration {
          pkgs = packages // pkgs; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            # not actually super secret, just dont want it in a public repo
            secrets = import ./secrets.nix;
          };
          modules = [
            # > Our main home-manager configuration file <
            ./home/avery_the_dragon/wyvern.nix
          ];
        };
        "avery_the_dragon@dragon" = lib.homeManagerConfiguration {
          pkgs = packages // pkgs; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            secrets = import ./secrets.nix;
          };
          # not actually super secret, just dont want it in a public repo
          modules = [
            # > Our main home-manager configuration file <
            ./home/avery_the_dragon/dragon.nix
          ];
        };
      };
    };
}
