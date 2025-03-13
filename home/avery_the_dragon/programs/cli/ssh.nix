{
  pkgs,
  lib,
  config,
  secrets,
  ...
}: {
  options = {
    cli.ssh.enable = lib.mkEnableOption "Enable git options";
  };

  config = lib.mkIf config.cli.ssh.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        science-ru-lilo = {
          host = "lilo.science.ru.nl";
          identityFile = "~/.ssh/science-ru-lilo";
          user = secrets.ssh.lilo-username;
        };
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
        gitea-itycodes = {
          host = "gitea.itycodes.org";
          identityFile = "~/.ssh/gitea-itycodes";
          user = "gitea";
        };

        rattop = {
          host = "192.168.5.74";
          identityFile = "~/.ssh/rattop";
        };

        dragon = {
          host = "dragon";
          hostname = "192.168.0.102";
          port = 55005;
          user = "avery_the_dragon";
          identityFile = "~/.ssh/dragon";
        };
      };
      # extraConfig = ''
      #   CanonicalDomains science.ru.nl
      #   CanonicalizeFallbackLocal no
      #   CanonicalizeHostname yes
      # '';
    };
  };
}
