{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./discord.nix
    ./kdeconnect.nix
    ./thunderbird.nix
    ./nheko.nix
    ./theme.nix
    ./kitty.nix
    ./cinny.nix
  ];

  home.packages = with pkgs; [];

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
