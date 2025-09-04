{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.ocaml.enable {
    programs.nixvim.plugins = {
      lsp.servers.ocamllsp = {
        enable = true;
      };
    };
  };
}
