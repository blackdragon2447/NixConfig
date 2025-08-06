{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    hosts.enableDocker = lib.mkEnableOption "Enable docker";
  };

  config = lib.mkIf config.hosts.enableDocker {
    environment = {
      systemPackages = with pkgs; [docker-compose];
    };
    virtualisation.docker = {
      enable = true;
    };

    users.users.avery_the_dragon = {
      extraGroups = ["docker"];
    };
  };
}
