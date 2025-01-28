{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.tex.enable {
    programs.nixvim = {
      files."ftplugin/tex.lua".autoCmd = [
        {
          event = ["BufWritePost"];
          command = "lua require('knap').process_once()";
        }
      ];
      plugins = {
        lsp.servers.texlab = {
          enable = true;

          extraOptions = {
            texlab.latexFormatter = "latexindent";
          };

          onAttach.function = ''
            require("lsp-format").on_attach(client, bufnr)
          '';
        };
      };
    };
  };
}
