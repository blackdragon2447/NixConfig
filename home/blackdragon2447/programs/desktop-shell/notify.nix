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
    inherit (config.colorscheme) palette;
  in {
    services.mako = lib.mkIf (config.desktop-shell.notify.enable && config.desktop-shell.notify.variant == "Wayland") {
      enable = true;
      layer = "overlay";
      backgroundColor = "#${palette.base00}";
      borderColor = "#${palette.base05}";
      progressColor = "over #${palette.base08}";
      textColor = "#${palette.base05}";
      defaultTimeout = 10000;
      borderSize = 4;
    };
  };
}
