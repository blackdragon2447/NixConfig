{ pkgs, ...}: {
  imports = [
    ./fish.nix
    ./bat.nix
    ./git.nix
    ./gpg.nix
    # ./shellcolor.nix
    ./starship.nix
    ./font.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    pfetch-rs
  ];
}
