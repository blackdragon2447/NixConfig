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
    zip.enable = true;
    aspell.enable = true;
    tealdeer.enable = true;
  };

  desktop = {
    firefox.enable = true;
    firefox.browserpass = false;
    discord.enable = true;
    nheko.enable = true;
    cinny.enable = true;
    iamb.enable = true;
    kdeconnect.enable = true;
    kitty = {
      enable = true;
      font-size = 11;
    };
    thunderbird.enable = true;
    eduvpn.enable = true;
    libreoffice.enable = true;
    freecad.enable = true;
  };

  games = {
    prismlauncher.enable = true;
  };

  neovim = {
    pdfview.wayland = true;
    enable = true;
  };

  wm = {
    riverwm = {
      enable = true;
      audioControls = true;
      playerControls = true;
      brightnessControls = true;
    };
    niri = {
      enable = true;
      audioControls = true;
      playerControls = true;
      brightnessControls = true;
    };
    leftwm.enable = true;
  };

  desktop-shell = {
    waybar = {
      enable = true;
      network-interface = "wlp170s0";
      modules = {
        # left = ["river/tags" "river/window"];
        left = ["custom/niri_workspaces" "custom/niri_window"];
        center = ["clock"];
        right = ["memory" "cpu" "wireplumber" "battery" "network"];
      };
    };
    menu = {
      enable = true;
      # dmenuCommand = "${pkgs.rofi-wayland}/bin/rofi -d";
      # runMenuCommand = "${pkgs.rofi-wayland}/bin/rofi -show drun -modi drun";
      lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f";
      # passmenuCommand = "${pkgs.rofi-pass-wayland}/bin/rofi-pass";
    };
    swaylock.enable = true;
    password-store.enable = true;
    notify = {
      enable = true;
      variant = "Wayland";
    };
  };

  devenvs = {
    nix.enable = true;
    tex.enable = true;
    java = {
      enable = false;
      enableGradle = true;
    };
    rust.enable = true;
    coq.enable = true;
    lua.enable = true;
    c.enable = true;
    haskell.enable = true;
  };

  # colorscheme = lib.mkDefault colorSchemes.darkviolet;
  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
