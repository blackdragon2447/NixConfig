{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hosts.enableAdb = lib.mkEnableOption "Enable adb and fastboot";
  };

  config = lib.mkIf config.hosts.enableAdb {
    programs.adb.enable = true;
    users.users.avery_the_dragon.extraGroups = ["adbusers"];
  };
}
