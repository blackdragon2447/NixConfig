{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./discord.nix
    ./kdeconnect.nix
    ./thunderbird.nix
    ./nheko.nix
    # ./theme.nix
    ./kitty.nix
    ./cinny.nix
    ./eduvpn.nix
    ./libreoffice.nix
    ./freecad.nix
    ./iamb.nix
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
