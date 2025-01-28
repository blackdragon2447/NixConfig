{
  inputs,
  lib,
  pkgs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.nix-colors.homeManagerModule
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = with outputs.overlays; [
      additions
      modifications
      niri
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;

      permittedInsecurePackages = [
        "olm-3.2.16"
        "cinny-4.2.3"
        "cinny-unwrapped-4.2.3"
      ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = "avery_the_dragon";
    homeDirectory = "/home/avery_the_dragon";
    stateVersion = "23.05";
  };
}
