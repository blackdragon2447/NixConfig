{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
  keybind = {
    modifiers ? ["None"],
    key,
    action,
  }:
    builtins.concatStringsSep " " [(builtins.concatStringsSep "+" modifiers) key action];
  keybinds = l: map keybind l;
  pow = x: y:
    if (y > 0)
    then x * (pow x (y - 1))
    else 1;
in {
  options = {
    riverwm.enable = lib.mkEnableOption "Enable RiverWM";
    riverwm.audioControls = lib.mkEnableOption "Enable audio control keybinds";
    riverwm.playerControls = lib.mkEnableOption "Enable player control keybinds";
    riverwm.brightnessControls = lib.mkEnableOption "Enable brightness control keybinds";
  };

  config = lib.mkIf config.riverwm.enable {
    home.packages = with pkgs; (
      [river-bnf rofi]
      ++ (
        if config.riverwm.audioControls
        then [pamixer]
        else []
      )
      ++ (
        if config.riverwm.playerControls
        then [playerctl]
        else []
      )
    );

    wayland.windowManager.river = {
      enable = true;

      extraSessionVariables = {
        _JAVA_AWT_WM_NONREPARENTING = 1;
        MOZ_ENABLE_WAYLAND = 1;
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      settings = {
        border-color-focused = "0x" + colors.base08;
        border-color-unfocused = "0x" + colors.base02;
        background-color = "0x" + colors.base00;

        focus-follows-cursor = "normal";

        set-repeat = "50 300";

        attach-mode = "bottom";

        default-layout = "rivertile";

        map = {
          normal =
            keybinds [
              {
                modifiers = ["Super" "Shift"];
                key = "Return";
                action = "spawn kitty";
              }
              {
                modifiers = ["Super"];
                key = "X";
                action = "close";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "Q";
                action = "exit";
              }
              {
                modifiers = ["Super"];
                key = "T";
                action = "toggle-float";
              }
              {
                modifiers = ["Super"];
                key = "E";
                action = "toggle-fullscreen";
              }
              {
                modifiers = ["Super"];
                key = "P";
                action = "spawn 'rofi -modi drun -show drun'";
                # TODO Custom scripts
              }
              {
                modifiers = ["Super" "Alt"];
                key = "Left";
                action = "move left 100";
              }
              {
                modifiers = ["Super" "Alt"];
                key = "Down";
                action = "move down 100";
              }
              {
                modifiers = ["Super" "Alt"];
                key = "Up";
                action = "move up 100";
              }
              {
                modifiers = ["Super" "Alt"];
                key = "Right";
                action = "move right 100";
              }
              {
                modifiers = ["Super" "Alt" "Control"];
                key = "Left";
                action = "snap left";
              }
              {
                modifiers = ["Super" "Alt" "Control"];
                key = "Down";
                action = "snap down";
              }
              {
                modifiers = ["Super" "Alt" "Control"];
                key = "Up";
                action = "snap up";
              }
              {
                modifiers = ["Super" "Alt" "Control"];
                key = "Right";
                action = "snap right";
              }
              {
                modifiers = ["Super" "Alt" "Shift"];
                key = "Left";
                action = "resize horizontal -100";
              }
              {
                modifiers = ["Super" "Alt" "Shift"];
                key = "Down";
                action = "resize vertical 100";
              }
              {
                modifiers = ["Super" "Alt" "Shift"];
                key = "Up";
                action = "resize vertical -100";
              }
              {
                modifiers = ["Super" "Alt" "Shift"];
                key = "Right";
                action = "resize horizontal 100";
              }
              {
                modifiers = ["Super"];
                key = "Down";
                action = "focus-view next";
              }
              {
                modifiers = ["Super"];
                key = "Up";
                action = "focus-view previous";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "Down";
                action = "swap next";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "Up";
                action = "swap previous";
              }
              {
                modifiers = ["Super"];
                key = "Return";
                action = "zoom";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "Left";
                action = "send-layout-cmd rivertile \"main-ratio -0.05\"";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "Right";
                action = "send-layout-cmd rivertile \"main-ratio +0.05\"";
              }
              {
                modifiers = ["Super" "Control"];
                key = "L";
                action = "spawn '/usr/bin/swaylock --image ~/.config/river/background.jpg -Fe --indicator-idle-visible --indicator-x-position 100 --indicator-y-position 1404 --indicator-radius 35'";
              }
            ]
            ++ keybinds (
              if config.riverwm.audioControls
              then [
                {
                  key = "XF86AudioRaiseVolume";
                  action = "spawn 'pamixer -i 5'";
                }
                {
                  key = "XF86AudioLowerVolume";
                  action = "spawn 'pamixer -d 5'";
                }
                {
                  key = "XF86AudioMute";
                  action = "spawn 'pamixer --toggle-mute'";
                }
              ]
              else []
            )
            ++ keybinds (
              if config.riverwm.playerControls
              then [
                {
                  key = "XF86AudioMedia";
                  action = "spawn 'playerctl play-pause'";
                }
                {
                  key = "XF86AudioPlay";
                  action = "spawn 'playerctl play-pause'";
                }
                {
                  key = "XF86AudioNext";
                  action = "spawn 'playerctl next'";
                }
                {
                  key = "XF86AudioPrev";
                  action = "spawn 'playerctl previous'";
                }
              ]
              else []
            )
            ++ keybinds (
              if config.riverwm.brightnessControls
              then [
                {
                  key = "XF86MonBrightnessUp";
                  action = "spawn 'light -A 5'";
                }
                {
                  key = "XF86MonBrightnessDown";
                  action = "spawn 'light -U 5'";
                }
              ]
              else []
            )
            ++ keybinds (lib.lists.flatten (map (x: [
              {
                modifiers = ["Super"];
                key = "${toString x}";
                action = "spawn 'river-bnf ${toString (pow 2 (x - 1))}'";
              }
              {
                modifiers = ["Super" "Shift"];
                key = "${toString x}";
                action = "set-view-tags ${toString (pow 2 (x - 1))}";
              }
            ]) (lib.lists.range 1 9)));
        };

        map-pointer = {
          normal = keybinds [
            {
              modifiers = ["Super"];
              key = "BTN_LEFT";
              action = "move-view";
            }
            {
              modifiers = ["Super"];
              key = "BTN_RIGHT";
              action = "resize-view";
            }
            {
              modifiers = ["Super"];
              key = "BTN_MIDDLE";
              action = "toggle-float";
            }
          ];
        };

        /*
           rule-add = {
          "-app-id" = ["\"bar\" csd" "\"*\" ssd"];
        };
        */

        # FIXME: This is wyvern's not global
        input = {
          "pointer-2362-628-PIXA3854:00_093A:0274_Touchpad" = {
            tap = "enabled";
            natural-scroll = "enabled";
          };
        };
      };

      extraConfig = ''
        rivertile -view-padding 6 -outer-padding 6 &
        riverctl send-layout-cmd rivertile "main-ratio 0.5"
      '' + (if config.waybar.enable then ''
        waybar &
      '' else ''
      '');
    };
  };
}
