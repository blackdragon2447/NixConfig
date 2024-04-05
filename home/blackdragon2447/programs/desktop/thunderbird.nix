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
      # Todo config ?
    };
  };
}
