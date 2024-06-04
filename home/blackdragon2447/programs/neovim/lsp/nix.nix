{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.devenvs.nix.enable {
    programs.nixvim.plugins = {
      lsp.servers.nil-ls = {
        enable = true;

        extraOptions = {
          flake.autoEvalInputs = true;
        };
      };

      none-ls.sources.formatting.alejandra = {
        enable = true;
      };
    };
  };
}
