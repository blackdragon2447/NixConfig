{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users
    ../common

    ../optional
  ];

  pipewire.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/add4601c-1c3c-4bfc-88d6-8eb10a9c9d6e";
  };

  networking = {
    networkmanager.enable = true;

    hostName = "dragon";
  };

  hosts.xorgSupport = true;

  # tmp hack

  users.users.blackdragon2447 = {
    extraGroups = ["wheel" "users"];
    group = "blackdragon2447";
  };

  users.groups.blackdragon2447 = {
    gid = 984;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  system.stateVersion = "23.11";
}
