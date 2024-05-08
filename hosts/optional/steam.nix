{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    hosts.enableSteam = lib.mkEnableOption "Enable the steam games launcher";
  };

  config = lib.mkIf config.hosts.enableSteam {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [mangohud protonup];

    programs.gamemode.enable = true;
  };
}
