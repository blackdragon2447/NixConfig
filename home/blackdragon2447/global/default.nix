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
    username = "blackdragon2447";
    homeDirectory = "/home/blackdragon2447";
    stateVersion = "23.05";
  };
}
