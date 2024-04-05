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

  gpg.enable = true;
  starship.enable = true;

  firefox.enable = true;
  firefox.browserpass = false;
  discord.enable = true;
  nheko.enable = true;
  kdeconnect.enable = true;
  kitty.enable = true;

  neovim.enable = true;

  riverwm.enable = true;
  riverwm.audioControls = true;
  riverwm.brightnessControls = true;

  waybar = {
    enable = true;
    network-interface = "wlp170s0";
  };

  # colorscheme = lib.mkDefault colorSchemes.spaceduck;
  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
