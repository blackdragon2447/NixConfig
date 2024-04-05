{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users
    ../common

    ../optional
  ];

  bluetooth.enable = true;

  networking = {
    networkmanager.enable = true;

    hostName = "wyvern";
  };

  # tmp hack

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  users.users.blackdragon2447 = {
    extraGroups = ["wheel" "users"];
    group = "blackdragon2447";
  };

  users.groups.blackdragon2447 = {
    gid = 1000;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    opengl.enable = true;
  };

  services.openssh = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
