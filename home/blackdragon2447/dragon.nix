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
  };

  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-gtk2;

  desktop = {
    firefox.enable = true;
    firefox.browserpass = false;
    discord.enable = true;
    nheko.enable = false;
    cinny.enable = true;
    kdeconnect.enable = true;
    eduvpn.enable = true;
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
      dmenuCommand = "${pkgs.rofi}/bin/rofi -dmenu";
      runMenuCommand = "${pkgs.rofi}/bin/rofi -show drun";
      lockCommand = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 20 3";
      passmenuCommand = "${pkgs.rofi-pass}/bin/rofi-pass";
      enabledMenus = ["Programs" "Minecraft" "Calc" "Screenshot" "Pass" "Logout"];
    };
    swaylock.enable = true;
    password-store.enable = true;
    macro-pad.enable = true;
  };

  devenvs = {
    nix.enable = true;
    tex.enable = true;
    java = {
      enable = true;
      enableGradle = true;
    };
    rust.enable = true;
    coq.enable = true;
    lua.enable = true;
  };

  games = {
    prismlauncher.enable = true;
  };

  colorscheme = lib.mkDefault colorSchemes.equilibrium-dark;
}
