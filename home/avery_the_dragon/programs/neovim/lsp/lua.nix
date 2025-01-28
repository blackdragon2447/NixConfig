{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.lua.enable {
    programs.nixvim.plugins = {
      lsp.servers.lua_ls = {
        enable = true;
      };

      none-ls.sources.formatting.stylua = {
        enable = true;
      };
    };
  };
}
