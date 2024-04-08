{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  options = {
    desktop-shell.swaylock = {
      enable = lib.mkEnableOption "Enable swaylock";
    };
  };

  config = lib.mkIf config.desktop-shell.swaylock.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;

        effect-blur = "20x3";
        screenshots = true;

        font = config.fontProfiles.regular.family;
        font-size = 15;

        line-uses-inside = true;
        disable-caps-lock-text = true;
        indicator-caps-lock = true;
        indicator-radius = 80;
        indicator-idle-visible = true;
        indicator-y-position = 800;

        ring-color = "#${colors.base02}";
        inside-wrong-color = "#${colors.base08}";
        ring-wrong-color = "#${colors.base08}";
        key-hl-color = "#${colors.base0B}";
        bs-hl-color = "#${colors.base08}";
        ring-ver-color = "#${colors.base09}";
        inside-ver-color = "#${colors.base09}";
        inside-color = "#${colors.base01}";
        text-color = "#${colors.base07}";
        text-clear-color = "#${colors.base01}";
        text-ver-color = "#${colors.base01}";
        text-wrong-color = "#${colors.base01}";
        text-caps-lock-color = "#${colors.base07}";
        inside-clear-color = "#${colors.base0C}";
        ring-clear-color = "#${colors.base0C}";
        inside-caps-lock-color = "#${colors.base09}";
        ring-caps-lock-color = "#${colors.base02}";
        separator-color = "#${colors.base02}";
      };
    };
  };
}
