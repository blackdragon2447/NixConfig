{
  pkgs,
  lib,
  config,
  secrets,
  ...
}: {
  options = {
    desktop.iamb.enable = lib.mkEnableOption "Enable Iamb";
  };

  config = lib.mkIf config.desktop.iamb.enable {
    home.packages = with pkgs; [iamb_8];

    xdg.configFile."iamb/config.toml".text = ''
      [profiles.itycodes]
      user_id = "@avery:itycodes.org"

      [profiles.matrix]
      user_id = "@blackdragon2447:matrix.org"

      [settings]
      username_display = "displayname"
      open_command = ["xdg-open"]

      [dirs]
      downloads = "/home/avery_the_dragon/Downloads/iamb/"

      [settings.image_preview]
      protocol.type = "kitty"

      [macros."normal|visual"]
      "gl" = "$"
      "gh" = "0"

      [settings.users]
      ${secrets.misc.iamb_users}
    '';
  };
}
