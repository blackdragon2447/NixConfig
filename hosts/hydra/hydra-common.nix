{pkgs, ...}: {
  imports = [./config];

  options = {};

  config = {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_6_6_hardened; # Latest lts
    };

    time.timeZone = "Europe/Amsterdam";

    environment.systemPackages = with pkgs; [
      vim
      git
    ];

    environment.persistence."/persistence" = {
      enable = true; # NB: Defaults to true, not needed
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
    };

    programs.fish.enable = true;

    users = {
      users = {
        admin = {
          uid = 1000;
          isNormalUser = true;
          extraGroups = ["wheel" "input" "dailout"]; # Enable ‘sudo’ for the user.
          shell = pkgs.fish;
          packages = with pkgs; [
            bat
            eza
            ripgrep
          ];

          hashedPassword = "$y$j9T$Avc/ihUTSr6LwA5FSBtXE/$6VkaXK.S/DLvRoOyhnpli6QGEqwJkoBtmcYFmE4q4nC";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpcvuAHTZpOJodgbJP3lI49qJLhPAV8vKFrRC3HzD3c"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGdEO8vWe8yWApzpIvuEfPV3Cpm+DZNY7zKX/xaqBuv"
          ];
        };

        vhosts = {
          uid = 5000;
          group = "vhosts";
          isSystemUser = true;
          createHome = true;
        };

        root = {
          hashedPassword = "$y$j9T$Avc/ihUTSr6LwA5FSBtXE/$6VkaXK.S/DLvRoOyhnpli6QGEqwJkoBtmcYFmE4q4nC";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpcvuAHTZpOJodgbJP3lI49qJLhPAV8vKFrRC3HzD3c"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGdEO8vWe8yWApzpIvuEfPV3Cpm+DZNY7zKX/xaqBuv"
          ];
        };
      };

      groups.vhosts = {
        gid = 5000;
        name = "vhosts";
      };
    };
  };
}
