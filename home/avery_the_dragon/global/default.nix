{
  inputs,
  lib,
  pkgs,
  outputs,
  ...
}: {
  imports = builtins.attrValues outputs.homeManagerModules;

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
      ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
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
