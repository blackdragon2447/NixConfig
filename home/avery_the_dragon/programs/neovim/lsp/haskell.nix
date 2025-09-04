{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.haskell.enable {
    home.packages = [pkgs.haskellPackages.haskell-language-server];
    programs.nixvim = {
      plugins = {
        lsp.servers.hls = {
          enable = true;
          installGhc = false;
          package = pkgs.haskell-language-server;
        };
      };
      extraPlugins = with pkgs.vimPlugins; [vim-ormolu];
    };
  };
}
