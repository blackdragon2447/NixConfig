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
      passmenu="${config.desktop-shell.menu.passmenuCommand}"
      ${text}
    '';
  mainMenu = writeMenuScript "menu_menu" ''
    menus=(
    ${builtins.concatStringsSep " " config.desktop-shell.menu.enabledMenus}
    )

    ${builtins.readFile ./scripts/dmenu_menu.sh}
  '';
  screenshotMenu = writeMenuScript "menu_screenshot" (builtins.readFile ./scripts/dmenu_screenshot.sh);
  logoutMenu = writeMenuScript "menu_logout" (builtins.readFile ./scripts/dmenu_logout.sh);
  minecraftMenu = writeMenuScript "menu_minecraft" (builtins.readFile ./scripts/dmenu_minecraft.sh);
in {
  options = {
    desktop-shell.menu = {
      enable = lib.mkEnableOption "Enable menu script";
      dmenuCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use for a dmenu prompt";
        default = "${pkgs.rofi-wayland}/bin/rofi -dmenu";
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
      passmenuCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use to access passwords";
        default = "${pkgs.rofi-pass-wayland}/bin/rofi-pass";
      };
      screenShotCommand = lib.mkOption {
        type = lib.types.str;
        description = "Command to use for screenshots";
        default = "${screenshotMenu}/bin/menu_screenshot";
      };
      enabledMenus = lib.mkOption {
        type = with lib.types; listOf (enum ["Programs" "Calc" "Minecraft" "Screenshot" "Pass" "Logout"]);
        description = "Menus to be enabled. (Minecraft needs prismlauncher installed)";
        default = ["Programs" "Calc" "Screenshot" "Pass" "Logout"];
      };
    };
  };

  config = lib.mkIf config.desktop-shell.menu.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [pkgs.rofi-calc];
    };

    home.packages = with pkgs; [
      mainMenu
      screenshotMenu
      logoutMenu
      minecraftMenu
      grim
      libnotify
      slurp
      wl-clipboard
    ];
  };
}
