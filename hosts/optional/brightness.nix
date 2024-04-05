{
  lib,
  config,
  ...
}: {
  options = {
    hosts.hasBrightness = lib.mkEnableOption "Enable brightness controlls through the light tool";
  };

  config = lib.mkIf config.hosts.hasBrightness {
    programs.light.enable = true;
  };
}
