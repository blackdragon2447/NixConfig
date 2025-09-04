{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.idris2.enable {
    programs.nixvim.plugins = {
      idris2 = {
        enable = true;
      };
      lsp.servers.idris2 = {
        enable = true;
      };
    };
  };
}
