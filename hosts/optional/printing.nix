{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hosts.enablePrinting = lib.mkEnableOption "enables printing";
  };

  config = lib.mkIf config.hosts.enablePrinting {
    services.printing = {
      enable = true;
      drivers = with pkgs; [hplipWithPlugin];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
