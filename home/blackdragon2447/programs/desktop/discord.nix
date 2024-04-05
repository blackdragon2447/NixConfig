{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    desktop.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.desktop.discord.enable {
    home.packages = with pkgs; [discord];
  };

  #TODO Beautiful Discord
}
