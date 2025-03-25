{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users
    ../common

    ../optional

    ./audio.nix
    ./exports.nix
    ./qemu-tap.nix
  ];

  hosts = {
    enableSteam = true;
    enableQemu = true;
    xorgSupport = true;
    enableDocker = true;
    enableSsh = true;
  };

  pipewire.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/add4601c-1c3c-4bfc-88d6-8eb10a9c9d6e";
  };

  systemd.services = {
    systemd-hibernate.environment = {
      SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    };

    systemd-suspend.environment = {
      SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    };
  };

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [8080 55005];
    };

    hostName = "dragon";
  };

  # tmp hack

  users.users.avery_the_dragon = {
    extraGroups = ["wheel" "users"];
    group = "avery_the_dragon";
  };

  users.groups.avery_the_dragon = {
    gid = 984;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  boot = {
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
  };

  system.stateVersion = "23.11";
}
