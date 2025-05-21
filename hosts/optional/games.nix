{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    hosts.enableSteam = lib.mkEnableOption "Enable the steam games launcher";
    hosts.enableHeroic = lib.mkEnableOption "Enable the herioc games launcher";
  };

  config =
    lib.mkIf config.hosts.enableSteam {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      environment.systemPackages = with pkgs; [mangohud protonup];

      programs.gamemode.enable = true;
      programs.gamescope.enable = true;
    }
    // lib.mkIf config.hosts.enableHeroic {
      environment.systemPackages = with pkgs; [
        (heroic.override {
          extraPkgs = pkgs: [
            pkgs.gamescope
          ];
        })
        mangohud
        protonup
      ];

      programs.gamescope.enable = true;
    };
}
