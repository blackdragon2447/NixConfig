{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b93d9386-93e3-42f6-86a1-620e85accc28";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=root"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b93d9386-93e3-42f6-86a1-620e85accc28";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=home"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b93d9386-93e3-42f6-86a1-620e85accc28";
    fsType = "btrfs";
    options = ["compress=zstd" "noatime" "subvol=nix"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/39FF-3F33";
    fsType = "vfat";
  };

  # fileSystems."/tmp" = {
  #   fsType = "tmpfs";
  # };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f37fb839-9c9c-4f26-9512-e35b83d0bbdb";}
  ];

  services.udev.extraRules = let
    battery-notify = pkgs.writeShellScriptBin "battery-notify" ''
      ${pkgs.libnotify}/bin/notify-send "Low battery" "Hibernating at 5%"
    '';
  in ''
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[5-9]", ENV{DBUS_SESSION_BUS_ADDRESS}="unix:path=/run/user/$$UID/bus", RUN+="${pkgs.sudo}/bin/sudo -Eu $$USER -c ${battery-notify}/bin/battery-notify"
    SUBSYSTEM=="tty", KERNEL=="ttyACM0", GROUP="dialout", MODE="0666"
  '';

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp170s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
