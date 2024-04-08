{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.rust.enable {
    programs.nixvim.plugins = {
      lsp.servers.rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };
}
