{pkgs, ...}: {
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
    ./zotero.nix
    ./vlc.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    config = {
      common = {
        default = [
          "wlr"
        ];
      };
    };
  };
}
