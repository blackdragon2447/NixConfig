{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [discord];
  };

  #TODO Beautiful Discord
}
