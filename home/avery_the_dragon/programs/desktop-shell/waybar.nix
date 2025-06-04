{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop-shell = {
      waybar.enable = lib.mkEnableOption "enable waybar";
      waybar.network-interface = lib.mkOption {
        default = "wlan0";
        defaultText = "wlan0";
        description = "The network interface waybar should use for displaying network info";
      };
      waybar.modules = {
        left = lib.mkOption {
          type = with lib.types; listOf str;
          description = "Left modules for waybar";
        };
        center = lib.mkOption {
          type = with lib.types; listOf str;
          description = "Center modules for waybar";
        };
        right = lib.mkOption {
          type = with lib.types; listOf str;
          description = "Right modules for waybar";
        };
      };
    };
  };

  config = lib.mkIf config.desktop-shell.waybar.enable {
    home.packages = [pkgs.nerd-fonts.symbols-only];
    programs.waybar = {
      enable = true;

      settings = {
        mainbar = {
          modules-left = config.desktop-shell.waybar.modules.left;
          modules-center = config.desktop-shell.waybar.modules.center;
          modules-right = config.desktop-shell.waybar.modules.right;

          "river/window".max-length = 50;

          "custom/niri_workspaces" = let
            niri_workspaces = pkgs.writeShellScriptBin "niri_workspaces" (builtins.readFile ./scripts/niri_workspaces.sh);
          in {
            format = "{}";
            interval = 1;
            return-type = "json";
            exec = "${niri_workspaces}/bin/niri_workspaces \"$WAYBAR_OUTPUT_NAME\" \"#${config.lib.stylix.colors.base09}\"";
            signal = 8;
          };

          "custom/niri_window" = let
            niri_window = pkgs.writeShellScriptBin "niri_window" (builtins.readFile ./scripts/niri_window.sh);
          in {
            format = "{}";
            interval = 1;
            return-type = "json";
            exec = "${niri_window}/bin/niri_window \"$WAYBAR_OUTPUT_NAME\" \"#${config.lib.stylix.colors.base09}\"";
            signal = 8;
          };

          layer = "top";

          network = {
            interface = config.desktop-shell.waybar.network-interface;
            format-wifi = "  {ifname} {essid} {ipaddr}";
            format-disconnected = "  {ifname} Disconnected";
            max-length = 50;
          };

          wireplumber = {
            format = "󰕾  {volume}%";
            format-muted = "󰖁 ";
          };

          battery = {
            format = "{icon} {capacity}%";
            full-aat = 99;
            format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰂀" "󰂁" "󰂂" "󰁹"];
          };

          cpu.format = "  {usage}%";
          memory.format = "󰆼 {percentage}%";
        };
      };

      style = ''
        * {
          font-family:
            Symbols Nerd Font,
            Font Awesome,
            Roboto;
          font-size: 16px;
          /* color: #${config.lib.stylix.colors.base07}; */
        }

        window#waybar {
          margin-top: 6px;
          margin-bottom: 6px;
        }
        /*-----module groups----*/
        .modules-right {
          margin: 2px 10px 2px 0;
        }
        .modules-center {
          margin: 2px 0 2px 0;
        }
        .modules-left {
          margin: 2px 0 2px 10px;
        }
        /*-----modules indv----*/
        #tags button {
          padding: 0;
          margin: 2px 2px;
          background-color: transparent;
        }
        #tags button:hover {
          box-shadow: inherit;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #temperature,
        #network,
        #wireplumber,
        #tray,
        #mode,
        #disk,
        #tags,
        #window,
        #idle_inhibitor
        #custom-niri_window {
          padding: 0px 5px;
          margin: 0px 5px;
        }
      '';
    };
  };
}
