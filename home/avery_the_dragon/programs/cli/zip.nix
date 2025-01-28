{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    cli.zip.enable = lib.mkEnableOption "Enable zip/unzip tools";
  };

  config = lib.mkIf config.cli.zip.enable {
    home.packages = with pkgs; [zip unzip];
  };
}
