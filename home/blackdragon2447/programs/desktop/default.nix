{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./discord.nix
    ./kdeconnect.nix
    ./thunderbird.nix
    ./nheko.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    kitty
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
