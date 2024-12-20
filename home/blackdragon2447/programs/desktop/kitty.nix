{
  lib,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
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
        color0 = "#${colors.base00}";
        color1 = "#${colors.base08}";
        color2 = "#${colors.base0B}";
        color3 = "#${colors.base0A}";
        color4 = "#${colors.base0D}";
        color5 = "#${colors.base0E}";
        color6 = "#${colors.base0C}";
        color7 = "#${colors.base05}";
        color8 = "#${colors.base03}";
        color9 = "#${colors.base08}";
        color10 = "#${colors.base0B}";
        color11 = "#${colors.base0A}";
        color12 = "#${colors.base0D}";
        color13 = "#${colors.base0E}";
        color14 = "#${colors.base0C}";
        color15 = "#${colors.base07}";
        color16 = "#${colors.base09}";
        color17 = "#${colors.base0F}";
        color18 = "#${colors.base01}";
        color19 = "#${colors.base02}";
        color20 = "#${colors.base04}";
        color21 = "#${colors.base06}";
      };
    };
  };
}
