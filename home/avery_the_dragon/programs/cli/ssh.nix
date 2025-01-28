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
      };
      # extraConfig = ''
      #   CanonicalDomains science.ru.nl
      #   CanonicalizeFallbackLocal no
      #   CanonicalizeHostname yes
      # '';
    };
  };
}
