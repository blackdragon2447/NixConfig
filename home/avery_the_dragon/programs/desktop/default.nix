{ pkgs, ... }:
{
  imports = [
    ./chat.nix
    ./firefox.nix
    ./kdeconnect.nix
    ./thunderbird.nix
    # ./theme.nix
    ./kitty.nix
    ./eduvpn.nix
    ./libreoffice.nix
    ./freecad.nix
    ./okular.nix
    ./zotero.nix
    ./vlc.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
}
