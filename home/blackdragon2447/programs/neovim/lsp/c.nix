{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.c.enable {
    programs.nixvim.plugins = {
      clangd-extensions = {
        enable = true;
      };
      lsp.servers.clangd = {
        enable = true;
      };

      none-ls = {
        sources.formatting = {
          clang_format = {
            enable = true;
            settings = {
              extra-args = [
                "--style=file"
                "--fallback-style=Mozilla"
              ];
            };
          };
        };
      };
    };
  };
}
