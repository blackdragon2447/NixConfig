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

  config = {
    services.mako = lib.mkIf (config.desktop-shell.notify.enable && config.desktop-shell.notify.variant == "Wayland") {
      enable = true;
      settings = {
        layer = "overlay";
        default-timeout = 10000;
        border-size = 4;
        outer-margin = "14,4";
        anchor = "bottom-right";
      };
    };
  };
}
