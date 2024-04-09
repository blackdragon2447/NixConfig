{
  lib,
  config,
  ...
}: {
  options = {
    hosts.xorgSupport = lib.mkEnableOption "Enable xorg support for this host";
  };

  config = lib.mkIf config.hosts.xorgSupport {
    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  };
}
