{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cli.starship.enable = lib.mkEnableOption "Enable starship options";
  };

  config = lib.mkIf config.cli.starship.enable {
    programs.starship = {
      enable = true;

      settings = {
        git_branch.symbol = " ";
        java.symbol = " ";
        gradle.symbol = " ";
        rust.symbol = " ";
        lua.symbol = "󰢱 ";
        php.symbol = "󰌟 ";
        package.symbol = "󰏗 ";
        sudo = {
          symbol = "󰞄 ";
          disabled = false;
        };
        python.symbol = " ";
      };
    };
  };
}
