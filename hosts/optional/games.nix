{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    hosts.enableSteam = lib.mkEnableOption "Enable the steam games launcher";
    hosts.enableHeroic = lib.mkEnableOption "Enable the heroic games launcher";
  };

  config = let
    heroic = pkgs.heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    };
  in {
    programs.steam = {
      enable = config.hosts.enableSteam;
      gamescopeSession.enable = true;
    };

    environment.systemPackages =
      (
        if config.hosts.enableSteam || config.hosts.enableHeroic
        then with pkgs; [
          mangohud
          protonup-ng
        ]
        else []
      )
      ++ (
        if config.hosts.enableHeroic
        then [heroic]
        else []
      );

    programs.gamemode.enable = config.hosts.enableSteam;
    programs.gamescope.enable = config.hosts.enableSteam || config.hosts.enableHeroic;
  };
}
