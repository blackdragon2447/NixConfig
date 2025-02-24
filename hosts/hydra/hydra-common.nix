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

    users = {
      users = {
        admin = {
          uid = 1000;
          isNormalUser = true;
          extraGroups = ["wheel" "input" "dailout"]; # Enable ‘sudo’ for the user.
          packages = with pkgs; [
            bat
            eza
            ripgrep
          ];
          hashedPassword = "$y$j9T$Avc/ihUTSr6LwA5FSBtXE/$6VkaXK.S/DLvRoOyhnpli6QGEqwJkoBtmcYFmE4q4nC";
        };

        vhosts = {
          uid = 5000;
          group = "vhosts";
          isSystemUser = true;
          createHome = true;
        };

        root = {
          hashedPassword = "$y$j9T$Avc/ihUTSr6LwA5FSBtXE/$6VkaXK.S/DLvRoOyhnpli6QGEqwJkoBtmcYFmE4q4nC";
        };
      };

      groups.vhosts = {
        gid = 5000;
        name = "vhosts";
      };
    };
  };
}
