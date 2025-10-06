{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.java.enable {
    programs.nixvim.plugins = {
      jdtls = {
        enable = true;
        # configuration = "/home/avery_the_dragon/.cache/jdtls/config";
        # data.__raw = "'~/.cache/jdtls/data/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')";
        settings = {
          cmd = [
            "${lib.getExe pkgs.jdt-language-server}"
            "-Declipse.application=org.eclipse.jdt.ls.core.id1"
            "-Dosgi.bundles.defaultStartLevel=4"
            "-Declipse.product=org.eclipse.jdt.ls.core.product"
            "-Dlog.level=ALL"
            "-noverify"
            "-Xmx1G"
            "-data"
            {
              __raw = ''"/home/avery_the_dragon/.cache/jdtls/data/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") '';
            }
            "-configuration"
            "/home/avery_the_dragon/.cache/jdtls/config/"
          ];
        };
      };
    };
  };
}
