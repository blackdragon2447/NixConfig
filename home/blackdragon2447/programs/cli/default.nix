{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./bat.nix
    ./git.nix
    ./gpg.nix
    ./shellcolor.nix
    ./starship.nix
    ./font.nix
    ./ssh.nix
    ./zip.nix
    ./aspell.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    pfetch-rs
    jq
  ];

  cli = {
    fish.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
  };
  neovim.enable = lib.mkDefault true;
}
