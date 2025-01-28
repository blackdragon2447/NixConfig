{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.cinny.enable = lib.mkEnableOption "Enable Cinny";
  };

  config = lib.mkIf config.desktop.cinny.enable {
    home.packages = with pkgs; [cinny-desktop];
  };
}
