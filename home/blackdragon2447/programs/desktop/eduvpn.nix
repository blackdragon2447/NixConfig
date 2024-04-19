{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.eduvpn.enable = lib.mkEnableOption "Enable EduVPN";
  };

  config = lib.mkIf config.desktop.eduvpn.enable {
    home.packages = with pkgs; [eduvpn-client];
  };
}
