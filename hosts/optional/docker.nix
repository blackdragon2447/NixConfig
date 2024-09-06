{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    hosts.enableDocker = lib.mkEnableOption "Enable the steam games launcher";
  };

  config = lib.mkIf config.hosts.enableDocker {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
