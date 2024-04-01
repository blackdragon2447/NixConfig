{ pkgs, lib, config, ... }:
{

  options = {
    kdeconnect.enable = lib.mkEnableOption "Enable KdeConnect";
  };

  config = lib.mkIf config.kdeconnect.enable {
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
      indicator = true;
    };

  };

}
