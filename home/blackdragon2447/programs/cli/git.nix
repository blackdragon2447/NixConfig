{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "Enable git options";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "BlackDragon2447";
      userEmail = "blackdragon2447@e.email";
      extraConfig = {
        commit.gpgsign = true;
        gpg.program = "${config.programs.gpg.package}/bin/gpg2";
        init.defaultBranch = "main";
      };
    };
  };
}
