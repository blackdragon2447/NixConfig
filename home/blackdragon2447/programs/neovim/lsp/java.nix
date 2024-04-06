{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.java.enable {
    programs.nixvim.plugins = {
      nvim-jdtls = {
        enable = true;
        # configuration = "/home/blackdragon2447/.cache/jdtls/config";
        # data.__raw = "'~/.cache/jdtls/data/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')";
        cmd = [
        ];
        extraOptions = {
          cmd.__raw = ''
            {
              "${lib.getExe pkgs.jdt-language-server}",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.level=ALL",
              "-noverify",
              "-Xmx1G",
              "-data", "/home/blackdragon2447/.cache/jdtls/data/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
              "-configuration", "/home/blackdragon2447/.cache/jdtls/config/",
            }
          '';
        };
      };
    };
  };
}
