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
in {
  options = {
    desktop.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf config.desktop.discord.enable {
    home.packages = [discord];

    xdg.configFile."discord/css/discord.css".text = ''
      .theme-dark {
          --logo-primary: #${colors.base08} /* discord nitro text, probably other stuff */;
          --header-primary: #${colors.base07} /* big text */;
          --header-secondary: #${colors.base06} /* subtext => id, active channel, code markdown, server of mention*/;
          --text-normal: #${colors.base06}/* normal text */;
          --background-primary: #${colors.base00}/* chat, call */;
          --background-secondary: #${colors.base01} /* friends sidebar */;
          --background-secondary-alt: #${colors.base00} /* call controls, profile */ ;
          --background-tertiary: #${colors.base00} !important /* server list, find or start convo backgr*/;
          --background-floating: #${colors.base00} /* context menus */;
          --channeltextarea-background: #${colors.base02} /* message textarea */;
          --deprecated-store-bg: black /* friends or activity or something */;
          --deprecated-quickswitcher-input-background: #${colors.base02} /* quick search text box */;
          --deprecated-card-editable-bg: rgba(77, 77, 77, 0.24) /* cards in settings (safe messaging, checkbox options)*/;
          --interactive-normal: rgb(228, 228, 228) /* supposedly icons */;
          --interactive-muted: #${colors.base03} /* muted channel, others */;
          --interactive-hover: #${colors.base07}# /* hover color*/;
          --text-link: #${colors.base0D} /* hyperlink color */;
          --interactive-active: #${colors.base07} /* selected tab*/;
          --text-muted: #${colors.base05} /* non important text */;
          --channels-default: #${colors.base05} /* channel not selected not hovered*/;
          --background-accent: #${colors.base01}; /* new messages */;
          --background-message-hover: #${colors.base01} /* message background on hover */;
          --background-modifier-accent: #${colors.base03} /* simmilar to border, but native to discord */;
          --background-modifier-hover: rgba(0, 0, 0, 0.534);
          --background-modifier-active: var(--background-modifier-hover);
          --background-modifier-selected: rgba(24, 50, 51, 0.5);
          --deprecated-card-bg: transparent /* some cards in the settings */;
          --scrollbar-thin-thumb:rgba(161, 161, 161, 0.712) /* thin scrollbar (such as channels in server) */;
          --scrollbar-thin-track: transparent /* thin scrollbar track */;
          --scrollbar-auto-thumb: rgb(189, 189, 189) /* thick scrollbar (such as active friends)*/;
          --scrollbar-auto-track: rgba(17, 17, 17, 0.315) /* thick scrollbar */;
          /* Custom variables - Theme */
          --color-main: #${colors.base08} /* main color theme */;
          --background-primary-extra: rgba(0, 0, 0, 0.466);
          --background-markup: #${colors.base01} /* background for code markup (``` blocks) */;
          --background-embed: #${colors.base02} /* background for embeds (video links, ...) */;
          --background-modal: #${colors.base02} /* main color of a modal dialog */;
          --background-dropdown: #${colors.base02} /* background of options in a dropdown */;
          --background-color: #${colors.base03} /* background color (for svg backgrounds and such)*/;
          --folder-background: #${colors.base02};
          --progress-thumb: rgb(71, 71, 71) /* volume bar thumb */;
          --progress-track-full: rgb(230, 230, 230) /* volume bar track - filled */;
          --progress-track-empty: rgba(109, 109, 109, 0.507) /* volume bar track - empty */;
      }
      ${builtins.readFile ./discord.css}
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
