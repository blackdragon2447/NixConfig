{
  pkgs,
  lib,
  config,
  secrets,
  ...
}: {
  options = {
    desktop.chat.cinny = lib.mkEnableOption "Enable Cinny";
    desktop.chat.discord = lib.mkEnableOption "Enable Discord";
    desktop.chat.iamb = lib.mkEnableOption "Enable Iamb";
    desktop.chat.dino = lib.mkEnableOption "Enable Dino";
    desktop.chat.signal = lib.mkEnableOption "Enable Signal";
  };

  config = let
    discord = pkgs.discord.override {
      withOpenASAR = false;
    };
  in {
    home.packages =
      []
      ++ (lib.optional config.desktop.chat.cinny pkgs.cinny-desktop)
      ++ (lib.optional config.desktop.chat.discord discord)
      ++ (lib.optional config.desktop.chat.iamb pkgs.iamb)
      ++ (lib.optional config.desktop.chat.dino pkgs.dino)
      ++ (lib.optional config.desktop.chat.signal pkgs.signal-desktop);

    xdg.configFile."iamb/config.toml".text = lib.mkIf config.desktop.chat.iamb ''
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
