{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    thunderbird.enable = lib.mkEnableOption "Enable Thunderbird";
  };

  config = lib.mkIf config.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      # Todo config ?
    };
  };
}
