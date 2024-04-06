{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  options = {
    desktop-shell = {
      waybar.enable = lib.mkEnableOption "enable waybar";
      waybar.network-interface = lib.mkOption {
        default = "wlan0";
        defaultText = "wlan0";
        description = "The network interface waybar should use for displaying network info";
      };
    };
  };

  config = lib.mkIf config.desktop-shell.waybar.enable {
    programs.waybar = {
      enable = true;

      settings = {
        mainbar = {
          modules-left = ["river/tags" "river/window"];
          modules-center = ["clock"];
          modules-right = ["memory" "cpu" "wireplumber" "battery" "network"];

          "river/window".max-length = 50;

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
            Font Awesome,
            Roboto;
          font-size: 16px;
          color: #${colors.base07};
        }

        window {
          /*font-weight: bold;*/
        }
        window#waybar {
          background: rgba(0, 0, 0, 0);
          margin-top: 6px;
        }
        /*-----module groups----*/
        .modules-right {
          background-color: rgba(0, 0, 0, 0);
          margin: 2px 10px 0 0;
        }
        .modules-center {
          background-color: rgba(0, 0, 0, 0);
          margin: 2px 0 0 0;
        }
        .modules-left {
          background-color: rgba(0, 0, 0, 0);
          margin: 2px 0 0 10px;
        }
        /*-----modules indv----*/
        #tags button {
          padding: 0;
          margin: 2px 2px;
          background-color: transparent;
        }
        #tags button:hover {
          box-shadow: inherit;
          background-color: #${colors.base05};
        }

        #tags button.occupied {
          background-color: #${colors.base04};
        }

        #tags button.focused {
          background-color: #${colors.base03};
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
        #idle_inhibitor {
          padding: 0px 5px;
          margin: 0px 5px;
          background-color: #${colors.base02};
          border-top: 5px solid #${colors.base09};
        }
      '';
    };
  };
}
