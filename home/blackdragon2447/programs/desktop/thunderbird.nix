{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.thunderbird.enable = lib.mkEnableOption "Enable Thunderbird";
  };

  config = lib.mkIf config.desktop.thunderbird.enable {
    programs.thunderbird = {
      enable = true;

      profiles.blackdragon2447 = {
        isDefault = true;
      };

      settings = {
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.compactmode.show" = true;
      };
      # Todo config ?
    };
  };
}
