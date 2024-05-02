{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.libreoffice.enable = lib.mkEnableOption "Enable Libreoffice";
  };

  config = lib.mkIf config.desktop.libreoffice.enable {
    home.packages = with pkgs; [libreoffice];
  };
}
