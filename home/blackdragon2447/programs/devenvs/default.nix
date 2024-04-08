{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./tex.nix
    ./java.nix
    ./rust.nix
  ];

  options = {
    devenvs = {
      nix.enable = lib.mkEnableOption "Enable nix dev tools and lsp";
      tex.enable = lib.mkEnableOption "Enable tex dev tools and lsp";
      java = {
        enable = lib.mkEnableOption "Enable java dev tools and lsp";
        enableGradle = lib.mkEnableOption "Enable gradle build too for java";
      };
      rust.enable = lib.mkEnableOption "Enable rust dev tools and lsp";
    };
  };

  config = {
    home.packages = with pkgs; [gnumake];
  };
}
