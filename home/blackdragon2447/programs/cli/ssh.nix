{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cli.ssh.enable = lib.mkEnableOption "Enable git options";
  };

  config = lib.mkIf config.cli.ssh.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        aur = {
          host = "aur.archlinux.org";
          identityFile = "~/.ssh/aur";
          user = "aur";
        };
        github = {
          host = "github.com";
          identityFile = "~/.ssh/github";
        };
        gitlab-cs-ru = {
          host = "gitlab.science.ru.nl";
          identityFile = "~/.ssh/gitlab-cs-ru";
        };
      };
    };
  };
}
