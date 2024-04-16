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
    ssh.enable = true;
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
      font-size = 11;
    };
    thunderbird.enable = true;
  };

  neovim.enable = true;

  wm = {
    riverwm.enable = true;
    riverwm.audioControls = true;
    riverwm.brightnessControls = true;
  };

  desktop-shell = {
    waybar = {
      enable = true;
      network-interface = "wlp170s0";
      modules = {
        left = ["river/tags" "river/window"];
        center = ["clock"];
        right = ["memory" "cpu" "wireplumber" "battery" "network"];
      };
    };
    menu = {
      enable = true;
      dmenuCommand = "${pkgs.wofi}/bin/wofi -d";
      runMenuCommand = "${pkgs.wofi}/bin/wofi -S drun";
      lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f";
      passmenuCommand = "${pkgs.wofi-pass}/bin/wofi-pass -s";
    };
    swaylock.enable = true;
    password-store.enable = true;
  };

  devenvs = {
    nix.enable = true;
    tex.enable = true;
    java = {
      enable = true;
      enableGradle = true;
    };
    rust.enable = true;
  };

  # colorscheme = lib.mkDefault colorSchemes.spaceduck;
  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
