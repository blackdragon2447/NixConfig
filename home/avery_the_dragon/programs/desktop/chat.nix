{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.chat.cinny = lib.mkEnableOption "Enable Cinny";
    desktop.chat.discord = lib.mkEnableOption "Enable Discord";
    desktop.chat.iamb = lib.mkEnableOption "Enable Iamb";
    desktop.chat.dino = lib.mkEnableOption "Enable Dino";
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
      ++ (lib.optional config.desktop.chat.dino pkgs.dino);
  };
}
