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
      enabledMenus = lib.mkOption {
        type = with lib.types; listOf (enum ["Programs" "Calc" "Minecraft" "Screenshot" "Pass" "Logout"]);
        description = "Menus to be enabled. (Minecraft needs prismlauncher installed)";
        default = ["Programs" "Calc" "Screenshot" "Pass" "Logout"];
      };
    };
  };

  config = lib.mkIf config.desktop-shell.menu.enable {
    programs.rofi = let
      inherit (config.colorscheme) colors;
      inherit (config.lib.formats.rasi) mkLiteral;
      themeFromBase16 = {
        base00,
        base01,
        base05,
        base06,
        base08,
        base0D,
        ...
      }: {
        /*
         *
        * Base16 {{scheme-name}} ROFI Color theme
        *
        * Authors
        *  Scheme: {{scheme-author}}
        *  Template: Tinted Theming (https://github.com/tinted-theming)
        */

        "*" = {
          red = mkLiteral "#${base08}FF";
          blue = mkLiteral "#${base0D}FF";
          lightfg = mkLiteral "#${base06}FF";
          lightbg = mkLiteral "#${base01}FF";
          foreground = mkLiteral "#${base05}FF";
          background = mkLiteral "#${base00}FF";
          background-color = mkLiteral "#${base00}00";
          separatorcolor = mkLiteral "@foreground";
          border-color = mkLiteral "@foreground";
          selected-normal-foreground = mkLiteral "@lightbg";
          selected-normal-background = mkLiteral "@lightfg";
          selected-active-foreground = mkLiteral "@background";
          selected-active-background = mkLiteral "@blue";
          selected-urgent-foreground = mkLiteral "@background";
          selected-urgent-background = mkLiteral "@red";
          normal-foreground = mkLiteral "@foreground";
          normal-background = mkLiteral "@background";
          active-foreground = mkLiteral "@blue";
          active-background = mkLiteral "@background";
          urgent-foreground = mkLiteral "@red";
          urgent-background = mkLiteral "@background";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-normal-background = mkLiteral "@lightbg";
          alternate-active-foreground = mkLiteral "@blue";
          alternate-active-background = mkLiteral "@lightbg";
          alternate-urgent-foreground = mkLiteral "@red";
          alternate-urgent-background = mkLiteral "@lightbg";
          spacing = mkLiteral "2";
        };
        window = {
          background-color = mkLiteral "@background";
          border = mkLiteral "1";
          padding = mkLiteral "5";
        };
        mainbox = {
          border = mkLiteral "0";
          padding = mkLiteral "0";
        };
        message = {
          border = mkLiteral "1px dash 0px 0px ";
          border-color = mkLiteral "@separatorcolor";
          padding = mkLiteral "1px ";
        };
        textbox = {
          text-color = mkLiteral "@foreground";
        };
        listview = {
          fixed-height = mkLiteral "0";
          border = mkLiteral "2px dash 0px 0px ";
          border-color = mkLiteral "@separatorcolor";
          spacing = mkLiteral "2px ";
          scrollbar = mkLiteral "true";
          padding = mkLiteral "2px 0px 0px ";
        };
        "element-text, element-icon" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        element = {
          border = mkLiteral "0";
          padding = mkLiteral "1px ";
        };
        "element normal.normal" = {
          background-color = mkLiteral "@normal-background";
          text-color = mkLiteral "@normal-foreground";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "@urgent-background";
          text-color = mkLiteral "@urgent-foreground";
        };
        "element normal.active" = {
          background-color = mkLiteral "@active-background";
          text-color = mkLiteral "@active-foreground";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
        };
        "element selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-foreground";
        };
        "element selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-foreground";
        };
        "element alternate.normal" = {
          background-color = mkLiteral "@alternate-normal-background";
          text-color = mkLiteral "@alternate-normal-foreground";
        };
        "element alternate.urgent" = {
          background-color = mkLiteral "@alternate-urgent-background";
          text-color = mkLiteral "@alternate-urgent-foreground";
        };
        "element alternate.active" = {
          background-color = mkLiteral "@alternate-active-background";
          text-color = mkLiteral "@alternate-active-foreground";
        };
        "scrollbar" = {
          width = mkLiteral "4px ";
          border = mkLiteral "0";
          handle-color = mkLiteral "@normal-foreground";
          handle-width = mkLiteral "8px ";
          padding = mkLiteral "0";
        };
        "sidebar" = {
          border = mkLiteral "2px dash 0px 0px ";
          border-color = mkLiteral "@separatorcolor";
        };
        "button" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };
        "button selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
        };
        "inputbar" = {
          spacing = mkLiteral "0px";
          text-color = mkLiteral "@normal-foreground";
          padding = mkLiteral "1px ";
          children = mkLiteral "[ prompt,textbox-prompt-colon,entry,case-indicator ]";
        };
        "case-indicator" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };
        "entry" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };
        "prompt" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };
        "textbox-prompt-colon" = {
          expand = mkLiteral "false";
          str = mkLiteral "\":\"";
          margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em ";
          text-color = mkLiteral "inherit";
        };
      };
    in {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = themeFromBase16 colors;
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
