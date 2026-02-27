{
  lib,
  config,
  ...
}:
{
  options = {
    cli.nh = {
      enable = lib.mkEnableOption "Enable nh";
    };
  };

  config = lib.mkIf config.cli.nh.enable {
    programs.nh = {
      enable = true;
      homeFlake = /home/avery_the_dragon/System;
      osFlake = /home/avery_the_dragon/System;
    };
  };
}
