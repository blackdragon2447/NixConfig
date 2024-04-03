{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nheko.enable = lib.mkEnableOption "Enable Nheko";
  };

  config = lib.mkIf config.nheko.enable {
    programs.nheko = {
      enable = true;
      # TODO Config
    };
  };
}
