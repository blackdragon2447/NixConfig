{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    pipewire.enable = lib.mkEnableOption "enables pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    # sound.enable = false;

    security.rtkit.enable = true;

    hardware.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
