{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./tex.nix
    ./java.nix
    ./rust.nix
    ./lua.nix
    ./coq.nix
    ./c.nix
    ./haskell.nix
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
      coq.enable = lib.mkEnableOption "Enable coq dev tools";
      lua.enable = lib.mkEnableOption "Enable lua dev tools";
      c.enable = lib.mkEnableOption "Enable c dev tools";
      haskell.enable = lib.mkEnableOption "Enable haskell dev tools";
    };
  };

  config = {
    home.packages = with pkgs; [gnumake];
  };
}
