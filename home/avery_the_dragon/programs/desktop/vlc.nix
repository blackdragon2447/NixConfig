{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.vlc.enable = lib.mkEnableOption "Enable Vlc";
  };

  config = lib.mkIf config.desktop.vlc.enable {
    home.packages = with pkgs; [vlc];
  };
}
