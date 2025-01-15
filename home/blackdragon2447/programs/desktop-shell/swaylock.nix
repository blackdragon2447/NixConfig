{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.colorscheme) palette;
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

        ring-color = "#${palette.base02}";
        inside-wrong-color = "#${palette.base08}";
        ring-wrong-color = "#${palette.base08}";
        key-hl-color = "#${palette.base0B}";
        bs-hl-color = "#${palette.base08}";
        ring-ver-color = "#${palette.base09}";
        inside-ver-color = "#${palette.base09}";
        inside-color = "#${palette.base01}";
        text-color = "#${palette.base07}";
        text-clear-color = "#${palette.base01}";
        text-ver-color = "#${palette.base01}";
        text-wrong-color = "#${palette.base01}";
        text-caps-lock-color = "#${palette.base07}";
        inside-clear-color = "#${palette.base0C}";
        ring-clear-color = "#${palette.base0C}";
        inside-caps-lock-color = "#${palette.base09}";
        ring-caps-lock-color = "#${palette.base02}";
        separator-color = "#${palette.base02}";
      };
    };
  };
}
