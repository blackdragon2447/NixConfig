{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./tex.nix
  ];

  options = {
    devenvs = {
      nix.enable = lib.mkEnableOption "Enable nix dev tools and lsp";
      tex.enable = lib.mkEnableOption "Enable tex dev tools and lsp";
    };
  };

  config = {
    home.packages = with pkgs; [gnumake];
  };
}
