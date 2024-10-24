{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.freecad.enable = lib.mkEnableOption "Enable FreeCad";
  };

  config = lib.mkIf config.desktop.freecad.enable {
    home.packages = with pkgs; [(freecad.override {withWayland = true;})];
  };
}
