{pkgs, lib, ...}: {
  imports = [
    ./firefox.nix
    ./discord.nix
    ./kdeconnect.nix
    ./thunderbird.nix
    ./nheko.nix
    ./theme.nix
    ./kitty.nix
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

  fish.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;

  neovim.enable = lib.mkDefault true;
}
