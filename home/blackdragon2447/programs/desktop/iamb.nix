{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.iamb.enable = lib.mkEnableOption "Enable Iamb";
  };

  config = lib.mkIf config.desktop.iamb.enable {
    home.packages = with pkgs; [iamb];

    xdg.configFile."iamb/config.toml".text = ''
      [profiles.user]
      user_id = "@blackdragon2447:matrix.org"
    '';
  };
}
