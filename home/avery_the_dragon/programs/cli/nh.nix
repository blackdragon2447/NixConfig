{
  lib,
  config,
  ...
}:
{
  options = {
    cli.nh.enable = lib.mkEnableOption "Enable nh";
    cli.nh.homeConfig = lib.mkOption {
      type = lib.types.str;
      description = "The homeConfiguration to use for `nh home` command";
    };
    cli.nh.osConfg = lib.mkOption {
      type = lib.types.str;
      description = "The nixosConfiguration to use for `nh os` command";
    };
  };

  config = lib.mkIf config.cli.nh.enable {
    cli.nh.homeConfig = lib.mkDefault "";
    cli.nh.osConfg = lib.mkDefault "";

    programs.nh = {
      enable = true;
      homeFlake = "/home/avery_the_dragon/System#" ++ config.cli.nh.homeConfig;
      osFlake = "/home/avery_the_dragon/System#" ++ config.cli.nh.osConfg;
    };
  };
}
