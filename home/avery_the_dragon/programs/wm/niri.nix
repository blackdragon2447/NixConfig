{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wm = {
      niri.enable = lib.mkEnableOption "Enable Niri";
      niri.audioControls = lib.mkEnableOption "Enable audio control keybinds";
      niri.playerControls = lib.mkEnableOption "Enable player control keybinds";
      niri.brightnessControls = lib.mkEnableOption "Enable brightness control keybinds";
    };
  };

  config = let
    inherit (config.colorscheme) palette;
  in
    lib.mkIf config.wm.niri.enable {
      home.packages = with pkgs; (
        [libsForQt5.qtwayland kdePackages.qtwayland]
        ++ (
          if config.wm.niri.audioControls
          then [pamixer]
          else []
        )
        ++ (
          if config.wm.niri.playerControls
          then [playerctl]
          else []
        )
      );

      # Xwayland?

      desktop-shell.xwayland.enable = lib.mkDefault true;

      desktop-shell.menu.screenShotCommand = lib.mkDefault "${pkgs.niri}/bin/niri msg action screenshot";

      xdg.desktopEntries.discord-wayland = {
        categories = ["Network" "InstantMessaging"];
        exec = "${pkgs.cage}/bin/cage Discord";
        genericName = "All-in-one cross-platform voice and text chat for gamers";
        icon = "discord";
        mimeType = ["x-scheme-handler/discord"];
        name = "Discord (Wayland)";
        type = "Application";
      };

      xdg.portal.config.niri = {
        default = ["wlr"];
        "org.freedesktop.impl.portal.Secret" = ["pass-secret-service"];
      };

      xdg.portal.config.niri-session = {
        default = ["wlr"];
        "org.freedesktop.impl.portal.Secret" = ["pass-secret-service"];
      };

      programs.niri = {
        enable = true;
        settings = with config.lib.niri.actions; {
          binds =
            {
              "Mod+Shift+Return".action = spawn "${pkgs.kitty}/bin/kitty";
              # "Mod+Shift+Return".action = spawn "${pkgs.foot}/bin/foot";
              "Mod+X".action = close-window;
              "Mod+Shift+Q".action = quit {skip-confirmation = true;};
              "Mod+E".action = fullscreen-window;

              "Mod+Return".action = move-column-to-first;
              "Mod+Shift+Left".action = move-column-left;
              "Mod+Shift+Right".action = move-column-right;
              "Mod+Shift+Up".action = move-column-to-workspace-up;
              "Mod+Shift+Down".action = move-column-to-workspace-down;

              "Mod+Ctrl+Left".action = move-column-to-monitor-left;
              "Mod+Ctrl+Right".action = move-column-to-monitor-right;
              "Mod+Ctrl+Up".action = move-column-to-monitor-up;
              "Mod+Ctrl+Down".action = move-column-to-monitor-down;

              "Mod+Left".action = focus-column-left;
              "Mod+Right".action = focus-column-right;
              "Mod+Up".action = focus-workspace-up;
              "Mod+Down".action = focus-workspace-down;

              "Mod+Tab".action = switch-preset-column-width;
              "Mod+Grave".action = maximize-column;

              "Mod+Shift+Comma".action = consume-window-into-column;
              "Mod+Shift+Period".action = expel-window-from-column;

              "Mod+Shift+S".action = screenshot;

              "Mod+Shift+Slash".action = show-hotkey-overlay;
            }
            // (
              lib.optionalAttrs config.wm.niri.audioControls
              {
                "XF86AudioMedia" = {
                  action = spawn "playerctl" "play-pause";
                  allow-when-locked = true;
                };
                "XF86AudioPlay" = {
                  action = spawn "playerctl" "play-pause";
                  allow-when-locked = true;
                };
                "XF86AudioNext" = {
                  action = spawn "playerctl" "next";
                  allow-when-locked = true;
                };
                "XF86AudioPrev" = {
                  action = spawn "playerctl" "previous";
                  allow-when-locked = true;
                };
              }
            )
            // (
              lib.optionalAttrs config.wm.niri.audioControls {
                "XF86AudioRaiseVolume" = {
                  action = spawn "pamixer" "-i" "5";
                  allow-when-locked = true;
                };
                "XF86AudioLowerVolume" = {
                  action = spawn "pamixer" "-d" "5";
                  allow-when-locked = true;
                };
                "XF86AudioMute" = {
                  action = spawn "pamixer" "--toggle-mute";
                  allow-when-locked = true;
                };
              }
            )
            // (
              lib.optionalAttrs config.wm.niri.brightnessControls
              {
                "XF86MonBrightnessUp" = {
                  action = spawn "light" "-A" "5";
                  allow-when-locked = true;
                };
                "XF86MonBrightnessDown" = {
                  action = spawn "light" "-U" "5";
                  allow-when-locked = true;
                };
              }
            )
            // (
              lib.optionalAttrs config.desktop-shell.menu.enable {
                "Mod+P".action = spawn "menu_menu";
              }
            )
            // (
              lib.optionalAttrs config.desktop-shell.swaylock.enable {
                "Mod+Control+L".action = spawn "swaylock";
              }
            );
          # TODO Screenshots.
          prefer-no-csd = true;
          spawn-at-startup =
            [
              {command = ["${pkgs.cage}/bin/cage" "Discord"];}
              {command = ["cinny"];}
              {command = ["firefox"];}
              {command = ["thunderbird"];}
            ]
            ++ (
              if config.desktop-shell.waybar.enable
              then [{command = ["waybar"];}]
              else []
            );

          environment = {
            DISPLAY = ":37";
            QT_QPA_PLATFORM = "wayland";
          };

          workspaces = {
            "03-home" = {
              name = " ";
            };
            "02-browser" = {
              name = "󰈹 ";
            };
            "01-chat" = {
              name = " ";
            };
            "00-mail" = {
              name = " ";
            };
          };

          input = {
            focus-follows-mouse.enable = true;
            keyboard.xkb.options = "caps:menu";
            touchpad = {
              click-method = "clickfinger";
              dwt = false;
              tap-button-map = "left-right-middle";
            };
          };

          cursor.size = 12;

          outputs = {
            eDP-1 = {
              scale = 1;
              background-color = "#" + palette.base02;
            };
          };

          layout.focus-ring = {
            enable = true;
            active.color = "#" + palette.base08;
            inactive.color = "#" + palette.base02;
            width = 2;
          };

          window-rules = [
            {
              matches = [{app-id = "firefox";}];
              open-on-workspace = "01-browser";
            }

            {
              matches = [
                {title = ".*Discord";}
                {app-id = "cinny";}
                {app-id = ".*nheko.*";}
              ];
              open-on-workspace = "chat";
            }

            {
              matches = [{app-id = "thunderbird";}];
              open-on-workspace = "03-mail";
            }
          ];

          environment = {
            _JAVA_AWT_WM_NONREPARENTING = "1";
            MOZ_ENABLE_WAYLAND = "1";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };
        };
      };
    };
}
