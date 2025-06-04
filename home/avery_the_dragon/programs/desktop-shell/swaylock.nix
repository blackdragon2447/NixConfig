{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    desktop-shell.swaylock = {
      enable = lib.mkEnableOption "Enable swaylock";
    };
  };

  config = lib.mkIf config.desktop-shell.swaylock.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;

        effect-blur = "20x3";
        screenshots = true;

        font = config.fontProfiles.regular.family;
        font-size = 15;

        line-uses-inside = true;
        disable-caps-lock-text = true;
        indicator-caps-lock = true;
        indicator-radius = 80;
        indicator-idle-visible = true;
        indicator-y-position = 800;
      };
    };
  };
}
