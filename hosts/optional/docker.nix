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
    environment = {
      systemPackages = with pkgs; [docker-compose];
    };
    virtualisation.docker = {
      enable = true;
    };
  };
}
