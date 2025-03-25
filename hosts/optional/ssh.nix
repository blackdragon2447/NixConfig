{
  lib,
  config,
  ...
}: {
  options = {
    hosts.enableSsh = lib.mkEnableOption "Enable Ssh";
  };

  config = lib.mkIf config.hosts.enableSsh {
    services.openssh = {
      enable = true;
      ports = [55005];
    };
  };
}
