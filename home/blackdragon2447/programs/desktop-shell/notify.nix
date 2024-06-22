{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    desktop-shell.notify = {
      enable = lib.mkEnableOption "Enable a notifiaction daemon";
      variant = lib.mkOption {
        type = lib.types.enum ["Xorg" "Wayland"];
        description = "Whether to use a notifiaction daemon setup for X or wayland";
        default = "Wayland";
      };
    };
  };

  config = let
    inherit (config.colorscheme) colors;
  in {
    services.mako = lib.mkIf (config.desktop-shell.notify.enable && config.desktop-shell.notify.variant == "Wayland") {
      enable = true;
      layer = "overlay";
      backgroundColor = "#${colors.base00}";
      borderColor = "#${colors.base05}";
      progressColor = "over #${colors.base08}";
      textColor = "#${colors.base05}";
      defaultTimeout = 10000;
      borderSize = 4;
    };
  };
}
