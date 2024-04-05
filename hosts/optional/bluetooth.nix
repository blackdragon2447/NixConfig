{ lib, config, ... }: {
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
