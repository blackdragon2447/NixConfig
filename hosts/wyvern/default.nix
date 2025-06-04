{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
    ./hardware-configuration.nix

    ./exports.nix

    ../common/users
    ../common

    ../optional
  ];

  hosts = {
    hasBluetooth = true;
    hasBrightness = true;
    enableSteam = true;
    enableHeroic = true;
    enableDocker = true;
    enablePrinting = true;
    enableQemu = true;
    enableWireshark = true;
    enableWireguard = true;
    enableAdb = true;
    xorgSupport = true;
  };

  networking = {
    networkmanager.enable = true;

    hostName = "wyvern";
    hosts = {
      "192.168.0.201" = ["hydra1.local"];
      "192.168.0.202" = ["hydra2.local"];
      "192.168.0.203" = ["hydra3.local"];
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      RUNTIME_PM_ON_AC = "auto";
    };
  };

  # tmp hack

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/f37fb839-9c9c-4f26-9512-e35b83d0bbdb";
  };

  users.users.avery_the_dragon = {
    extraGroups = ["wheel" "users" "dailout" "wireshark"];
    group = "avery_the_dragon";
  };

  users.groups = {
    dailout = {};
    avery_the_dragon = {
      gid = 1000;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    graphics.enable = true;
  };

  services.openssh = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
