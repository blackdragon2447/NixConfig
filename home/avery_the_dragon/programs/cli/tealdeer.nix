{
  config,
  lib,
  ...
}: {
  options = {
    cli.tealdeer.enable = lib.mkEnableOption "Enable tealdeer options";
  };
  config = lib.mkIf config.cli.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        auto_update = true;
      };
    };
  };
}
