{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    packages = import ./pkgs {inherit pkgs;};
  in {
    inherit packages;
    formatter.${system} = pkgs.alejandra;

    overlays = import ./overlays {inherit inputs outputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager {inherit inputs;};

    nixosConfigurations = {
      wyvern = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/wyvern
        ];
      };
      dragon = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/dragon
        ];
      };
    };

    homeConfigurations = {
      "blackdragon2447@wyvern" = lib.homeManagerConfiguration {
        pkgs = packages // pkgs; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/blackdragon2447/wyvern.nix
        ];
      };
      "blackdragon2447@dragon" = lib.homeManagerConfiguration {
        pkgs = packages // pkgs; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/blackdragon2447/dragon.nix
        ];
      };
    };
  };
}
