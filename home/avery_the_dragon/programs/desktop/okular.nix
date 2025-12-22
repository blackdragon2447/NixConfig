{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    desktop.okular.enable = lib.mkEnableOption "Enable Okular";
  };

  config = lib.mkIf config.desktop.okular.enable {
    home.packages = with pkgs; [ kdePackages.okular ];
  };
}
