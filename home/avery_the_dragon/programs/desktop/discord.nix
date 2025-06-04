{
  config,
  pkgs,
  lib,
  ...
}: let
  discord = pkgs.discord.override {
    withOpenASAR = false;
  };
in {
  options = {
    desktop.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.desktop.discord.enable {
    home.packages = [discord];
  };
}
