{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [
    ./global
    ./programs
    inputs.nix-colors.homeManagerModule
  ];

  cli = {
    gpg.enable = true;
    starship.enable = true;
  };

  desktop = {
    firefox.enable = true;
    firefox.browserpass = false;
    discord.enable = true;
    nheko.enable = false;
    cinny.enable = true;
    kdeconnect.enable = true;
    kitty = {
      enable = true;
      font-size = 9;
    };
    thunderbird.enable = true;
  };

  neovim.enable = true;

  wm = {
    riverwm.enable = true;
    leftwm = {
      enable = true;
      themes = {
        ringed-earth.enable = true;
        system.enable = true;
      };
    };
  };

  desktop-shell = {
    waybar = {
      enable = true;
      network-interface = "wlp5s0";
      modules = {
        left = ["river/tags" "river/window"];
        center = ["clock"];
        right = ["memory" "cpu" "wireplumber" "network"];
      };
    };
    menu = {
      enable = true;
      dmenuCommand = "${pkgs.wofi}/bin/wofi -d";
      runMenuCommand = "${pkgs.wofi}/bin/wofi -S drun";
      lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f";
      passmenuCommand = "${pkgs.wofi-pass}/bin/wofi-pass -s";
      enabledMenus = ["Programs" "Minecraft" "Screenshot" "Pass" "Logout"];
    };
    swaylock.enable = true;
    password-store.enable = true;
  };

  devenvs = {
    nix.enable = true;
    tex.enable = false;
    java = {
      enable = true;
      enableGradle = true;
    };
  };

  games = {
    prismlauncher.enable = true;
  };

  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
