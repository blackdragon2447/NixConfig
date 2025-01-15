{
  lib,
  config,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  options = {
    desktop.kitty = {
      enable = lib.mkEnableOption "Enable the kitty terminal";
      font-size = lib.mkOption {
        type = lib.types.int;
      };
    };
  };

  config = lib.mkIf config.desktop.kitty.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = config.fontProfiles.monospace.family;
        package = config.fontProfiles.monospace.package;
        size = config.desktop.kitty.font-size;
      };

      settings = {
        color0 = "#${palette.base00}";
        color1 = "#${palette.base08}";
        color2 = "#${palette.base0B}";
        color3 = "#${palette.base0A}";
        color4 = "#${palette.base0D}";
        color5 = "#${palette.base0E}";
        color6 = "#${palette.base0C}";
        color7 = "#${palette.base05}";
        color8 = "#${palette.base03}";
        color9 = "#${palette.base08}";
        color10 = "#${palette.base0B}";
        color11 = "#${palette.base0A}";
        color12 = "#${palette.base0D}";
        color13 = "#${palette.base0E}";
        color14 = "#${palette.base0C}";
        color15 = "#${palette.base07}";
        color16 = "#${palette.base09}";
        color17 = "#${palette.base0F}";
        color18 = "#${palette.base01}";
        color19 = "#${palette.base02}";
        color20 = "#${palette.base04}";
        color21 = "#${palette.base06}";
      };
    };
  };
}
