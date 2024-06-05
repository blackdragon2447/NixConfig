{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
  discord = pkgs.discord.override {
    withOpenASAR = false;
  };
  css = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/deathbeam/base16-discord/main/themes/base16-equilibrium-dark.theme.css";
    hash = "sha256-IomsXpWUMmi8yZoVPM2IXJGaNolTlezRkD1QNfODemE=";
  };
in {
  options = {
    desktop.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.desktop.discord.enable {
    home.packages = [discord];

    # xdg.configFile."discord/css/discord.css".source = css;
    xdg.configFile."discord/css/discord.css".text = ''
      /**
      * @name base16 Equilibrium Dark
      * @author Carlo Abelli
      * @version 1.0.0
      * @description base16 Equilibrium Dark theme generated from https://github.com/tinted-theming/schemes
      **/

      :root {
          --base00: #${colors.base00}; /* Black */
          --base01: #${colors.base01}; /* Bright Black */
          --base02: #${colors.base02}; /* Grey */
          --base03: #${colors.base03}; /* Brighter Grey */
          --base04: #${colors.base04}; /* Bright Grey */
          --base05: #${colors.base05}; /* White */
          --base06: #${colors.base06}; /* Brighter White */
          --base07: #${colors.base07}; /* Bright White */
          --base08: #${colors.base08}; /* Red */
          --base09: #${colors.base09}; /* Orange */
          --base0A: #${colors.base0A}; /* Yellow */
          --base0B: #${colors.base0B}; /* Green */
          --base0C: #${colors.base0C}; /* Cyan */
          --base0D: #${colors.base0D}; /* Blue */
          --base0E: #${colors.base0E}; /* Purple */
          --base0F: #${colors.base0F}; /* Magenta */

          --primary-630: var(--base00); /* Autocomplete background */
          --primary-660: var(--base00); /* Search input background */
      }

      .theme-light, .theme-dark {
          --search-popout-option-fade: none; /* Disable fade for search popout */
          --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
          --home-background: var(--base00);
          --background-primary: var(--base00);
          --background-secondary: var(--base01);
          --background-secondary-alt: var(--base01);
          --channeltextarea-background: var(--base01);
          --background-tertiary: var(--base00);
          --background-accent: var(--base0E);
          --background-floating: var(--base01);
          --background-modifier-selected: var(--base00);
          --text-normal: var(--base05);
          --text-secondary: var(--base00);
          --text-muted: var(--base03);
          --text-link: var(--base0C);
          --interactive-normal: var(--base05);
          --interactive-hover: var(--base0C);
          --interactive-active: var(--base0A);
          --interactive-muted: var(--base03);
          --header-primary: var(--base06);
          --header-secondary: var(--base03);
          --scrollbar-thin-track: transparent;
          --scrollbar-auto-track: transparent;
      }
    '';

    systemd.user.services.discord-css = {
      Install = {
        WantedBy = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "serve-discord-css" ''
          ${pkgs.python3}/bin/python3 -m http.server 55826 -d /home/blackdragon2447/.config/discord/css/
        ''}";
      };
    };
  };

  #TODO Beautiful Discord
}
