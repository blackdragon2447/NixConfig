# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs ? import <nixpkgs> {}}: rec {
  # example = pkgs.callPackage ./example { };
  listings-rust = pkgs.callPackage ./listings-rust {};
  shellcolord = pkgs.callPackage ./shellcolord {};
  macro-script = pkgs.callPackage ./macro-script {};
}
