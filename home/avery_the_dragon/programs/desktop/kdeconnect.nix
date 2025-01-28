{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.kdeconnect.enable = lib.mkEnableOption "Enable KdeConnect";
  };

  config = lib.mkIf config.desktop.kdeconnect.enable {
    # Hide all .desktop, except for org.kde.kdeconnect.settings
    xdg.desktopEntries = {
      "org.kde.kdeconnect.sms" = {
        exec = "";
        name = "KDE Connect SMS";
        settings.NoDisplay = "true";
      };
      "org.kde.kdeconnect.nonplasma" = {
        exec = "";
        name = "KDE Connect Indicator";
        settings.NoDisplay = "true";
      };
    };

    services.kdeconnect = {
      enable = true;
      # package = pkgs.kdePackages.kdeconnect-kde;
      indicator = true;
    };
  };
}
