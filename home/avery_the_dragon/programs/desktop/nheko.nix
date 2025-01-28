{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.nheko.enable = lib.mkEnableOption "Enable Nheko";
  };

  config = lib.mkIf config.desktop.nheko.enable {
    programs.nheko = {
      enable = true;
      # TODO Config
    };
  };
}
