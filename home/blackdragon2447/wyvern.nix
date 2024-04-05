{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [
    ./global
    ./programs
    inputs.nix-colors.homeManagerModule
  ];

  cli = {
    gpg.enable = true;
    starship.enable = true;
  };

  desktop = {
    firefox.enable = true;
    firefox.browserpass = false;
    discord.enable = true;
    nheko.enable = true;
    kdeconnect.enable = true;
    kitty.enable = true;
  };

  neovim.enable = true;

  wm = {
    riverwm.enable = true;
    riverwm.audioControls = true;
    riverwm.brightnessControls = true;
  };

  shell = {
    waybar = {
      enable = true;
      network-interface = "wlp170s0";
    };
  };

  devenvs = {
    nix.enable = true;
    tex.enable = true;
  };

  # colorscheme = lib.mkDefault colorSchemes.spaceduck;
  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
