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
        };
      };
      extraPlugins = with pkgs.vimPlugins; [vim-ormolu];
    };
  };
}
