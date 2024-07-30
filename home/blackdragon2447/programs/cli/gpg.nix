{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cli.gpg.enable = lib.mkEnableOption "Enable gpg options";
  };

  config = lib.mkIf config.cli.gpg.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [
        "11997C49A888A4F0885C8827D384D3615A9A56E9"
        "AD655059B73D6E91A9404B4BE659BE73608E2FDE"
      ];
      # pinentyFlavour = "curses";
      pinentryPackage = pkgs.pinentry-rofi;
      # pinentryPackage = pkgs.pinentry-gtk2;
      # pinentryPackage = pkgs.pinentry-curses;
    };

    programs = let
      fixGpg = ''
        gpgconf --launch gpg-agent
      '';
    in {
      fish.loginShellInit = fixGpg;

      gpg = {
        enable = true;
        settings = {
          keyid-format = "LONG";
          with-keygrip = true;
        };
        # TODO: Keys?
      };
    };

    systemd.user.services = {
      # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
      # So that SSH config does not have to know the UID
      link-gnupg-sockets = {
        Unit = {
          Description = "link gnupg sockets from /run to /home";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
          ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
          RemainAfterExit = true;
        };
        Install.WantedBy = ["default.target"];
      };
    };
  };
}
