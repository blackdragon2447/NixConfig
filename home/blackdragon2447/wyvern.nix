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

  fish.enable = true;
  git.enable = true;
  gpg.enable = true;
  starship.enable = true;

  firefox.enable = true;
  firefox.browserpass = false;
  discord.enable = true;
  kdeconnect.enable = true;

  neovim.enable = true;

  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
