{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.zotero.enable = lib.mkEnableOption "Enable Zotero";
  };

  config = lib.mkIf config.desktop.zotero.enable {
    home.packages = with pkgs; [zotero];
  };
}
