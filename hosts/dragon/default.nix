{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users
    ../common

    ../optional

    ./audio.nix
  ];

  hosts = {
    enableSteam = true;
    xorgSupport = true;
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

    hostName = "dragon";
  };

  # tmp hack

  users.users.blackdragon2447 = {
    extraGroups = ["wheel" "users"];
    group = "blackdragon2447";
  };

  users.groups.blackdragon2447 = {
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
