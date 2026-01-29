{
  lib,
  config,
  ...
}:
{
  options = {
    cli.nh = {
      enable = lib.mkEnableOption "Enable nh";
      homeConfig = lib.mkOption {
        type = lib.types.str;
        description = "The homeConfiguration to use for `nh home` command";
        default = "";
      };
      osConfig = lib.mkOption {
        type = lib.types.str;
        description = "The nixosConfiguration to use for `nh os` command";
        default = "";
      };
    };
  };

  config = lib.mkIf config.cli.nh.enable {
    programs.nh = {
      enable = true;
      homeFlake = lib.strings.concatStrings (
        [
          "/home/avery_the_dragon/System"
        ]
        ++ (lib.optionals (config.cli.nh.homeConfig != "") [
          "#"
          config.cli.nh.homeConfig
        ])
      );
      osFlake = lib.strings.concatStrings (
        [
          "/home/avery_the_dragon/System"
        ]
        ++ (lib.optionals (config.cli.nh.osConfig != "") [
          "#"
          config.cli.nh.osConfig
        ])
      );
    };
  };
}
