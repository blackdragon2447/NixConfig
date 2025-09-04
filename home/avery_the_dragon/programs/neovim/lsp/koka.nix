{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.koka.enable {
    programs.nixvim.plugins = {
      lsp.servers.koka = {
        enable = true;
      };
    };
  };
}
