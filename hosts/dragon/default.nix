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
  ];

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

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    opengl.enable = true;
  };

  system.stateVersion = "23.11";
}
