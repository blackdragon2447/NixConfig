{
  config,
  pkgs,
  lib,
  ...
}: let
  writeMenuScript = name: text:
    pkgs.writeShellScriptBin name ''
      dmenu="${config.desktop-shell.menu.dmenuCommand}"
      runmenu="${config.desktop-shell.menu.runMenuCommand}"
      lock="${config.desktop-shell.menu.lockCommand}"
      ${text}
    '';
  mainMenu = writeMenuScript "menu_menu" (builtins.readFile ./scripts/dmenu_menu.sh);
  screenshotMenu = writeMenuScript "menu_screenshot" (builtins.readFile ./scripts/dmenu_screenshot.sh);
  logoutMenu = writeMenuScript "menu_logout" (builtins.readFile ./scripts/dmenu_logout.sh);
in {
  options = {
    desktop-shell.menu = {
      enable = lib.mkEnableOption "Enable menu script";
      dmenuCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use for a dmenu prompt";
        default = "${pkgs.rofi-wayland}/bin/rofi";
      };
      runMenuCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use for program runner";
        default = "${pkgs.rofi-wayland}/bin/rofi -modi drun -show drun";
      };
      lockCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use to lock the screen";
        default = "${pkgs.swaylock}/bin/swaylock -f";
      };
    };
  };

  config = lib.mkIf config.desktop-shell.menu.enable {
    home.packages = with pkgs; [
      mainMenu
      screenshotMenu
      logoutMenu
      grim
      libnotify
      slurp
      wl-clipboard
    ];
  };
}
