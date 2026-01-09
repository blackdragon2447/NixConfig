{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:
{
  options = {
    cli.git.enable = lib.mkEnableOption "Enable git options";
  };

  config = lib.mkIf config.cli.git.enable {
    home.packages = with pkgs; [ git-crypt ];
    programs.git = {
      enable = true;
      settings = {
        commit.gpgsign = true;
        gpg.program = "${config.programs.gpg.package}/bin/gpg2";
        init.defaultBranch = "main";
      };
      includes = [
        {
          path = "~/.config/git/gh-http";
          condition = "hasconfig:remote.*.url:https://github.com/**";
        }
        {
          path = "~/.config/git/gh-ssh";
          condition = "hasconfig:remote.*.url:git@github.com:*/**";
        }
        {
          path = "~/.config/git/gitea-itycodes-ssh";
          condition = "hasconfig:remote.*.url:gitea@gitea.itycodes.org:*/**";
        }
        {
          path = "~/.config/git/gitea-itycodes-http";
          condition = "hasconfig:remote.*.url:https://gitea.itycodes.org/**";
        }
        /*
          {
            path = "~/.config/git/gl-cs-ru-http";
            condition = "hasconfig:remote.*.url:https://github.com/**";
          }
        */
        {
          path = "~/.config/git/gl-cs-ru-ssh";
          condition = "hasconfig:remote.*.url:git@gitlab.science.ru.nl:*/**";
        }
        {
          path = "~/.config/git/git-gusted-ssh";
          condition = "hasconfig:remote.*.url:ssh://forgejo@git.gusted.xyz/*/**";
        }
        {
          path = "~/.config/git/codeberg-ssh";
          condition = "hasconfig:remote.*.url:ssh://git@codeberg.org/*/**";
        }
      ];
    };

    xdg.configFile."git/gh-http".text = ''
      [credential]
          helper = store --file ~/.config/git/gh-http-cred
          helper = cache --timeout 30000

      [user]
          email = "blackdragon2447@e.email"
          name = "BlackDragon2447"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/gh-http-cred".text = secrets.git.githubKey;

    xdg.configFile."git/gh-ssh".text = ''
      [user]
          email = "blackdragon2447@e.email"
          name = "BlackDragon2447"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/git-gusted-ssh".text = ''
      [user]
          email = "blackdragon2447@e.email"
          name = "avery"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/codeberg-ssh".text = ''
      [user]
          email = "blackdragon2447@e.email"
          name = "avery_the_dragon"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/gitea-itycodes-ssh".text = ''
      [user]
          email = "avery@gitea.itycodes.org"
          name = "Avery"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/gitea-itycodes-http".text = ''
      [credential]
          helper = store --file ~/.config/git/gitea-itycodes-http-cred
          helper = cache --timeout 30000

      [user]
          email = "avery@gitea.itycodes.org"
          name = "Avery"
          signingkey = 9D001FB4DADDA597
    '';

    xdg.configFile."git/gitea-itycodes-http-cred".text = secrets.git.gitea-itycodesKey;

    xdg.configFile."git/gl-cs-ru-ssh".text = secrets.git.uniGitConfig;
  };
}
