{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.haskell.enable {
    programs.nixvim = {
      plugins = {
        lsp.servers.hls = {
          enable = true;
          installGhc = false;
          packages = pkgs.haskell-language-server;
        };
      };
      extraPlugins = with pkgs.vimPlugins; [vim-ormolu];
    };
  };
}
