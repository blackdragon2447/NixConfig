{
  lib,
  config,
  ...
}: {
  options = {
    hosts.hasBluetooth = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf config.hosts.hasBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
