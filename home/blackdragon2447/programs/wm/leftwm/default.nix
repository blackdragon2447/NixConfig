{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./themes/ringed-earth.nix
    ./themes/system.nix
  ];

  options = {
    wm.leftwm.enable = lib.mkEnableOption "Enable leftwm windowmanager";
  };

  config = lib.mkIf config.wm.leftwm.enable {
    home.packages = with pkgs; [leftwm];

    xdg.configFile."leftwm/config.ron".text = ''
      #![enable(implicit_some)]
      (
          modkey: "Mod4",
          mousekey: "Mod4",
          tags: [
              "1",
              "2",
              "3",
              "4",
              "5",
              "6",
              "7",
              "8",
              "9",
          ],
          layouts: [
              "MainAndVertStack",
              "RightMainAndVertStack",
              // "LeftWiderRightStack",
              // "RightWiderLeftStack",
              "MainAndHorizontalStack",
      		"MainAndDeck",
              "Monocle",
          ],
          layout_mode: Tag,
          insert_behavior: Bottom,
          scratchpad: [
              (name: "Terminal", value: "kitty", x: None, y: None, height: None, width: None, start_sticky: true),
              (name: "Surf", value: "surf duckduckgo.com", x: None, y: None, height: None, width: None),
          ],
          window_rules: [
      		(window_class: "riscv_vm", spawn_floating: true),
      	],
          disable_current_tag_swap: false,
          disable_tile_drag: false,
          focus_behaviour: Sloppy,
          focus_new_windows: true,
          keybind: [
              (command: Execute, value: "menu_menu", modifier: ["modkey"], key: "p"),
              (command: Execute, value: "kitty", modifier: ["modkey", "Shift"], key: "Return"),
              (command: CloseWindow, value: "", modifier: ["modkey"], key: "x"),
              (command: SoftReload, value: "", modifier: ["modkey"], key: "q"),
              (command: HardReload, value: "", modifier: ["modkey", "Control"], key: "q"),
              (command: Execute, value: "pkill leftwm", modifier: ["modkey", "Shift"], key: "q"),
              (command: Execute, value: "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 20 3", modifier: ["modkey", "Control"], key: "l"),
              (command: MoveToLastWorkspace, value: "", modifier: ["modkey", "Shift"], key: "w"),
              (command: SwapTags, value: "", modifier: ["modkey"], key: "w"),
              (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "k"),
              (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "j"),
              (command: MoveWindowTop, value: "", modifier: ["modkey"], key: "Return"),
              (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "k"),
              (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "j"),
              (command: NextLayout, value: "", modifier: ["modkey", "Control"], key: "k"),
              (command: PreviousLayout, value: "", modifier: ["modkey", "Control"], key: "j"),
              (command: FocusWorkspaceNext, value: "", modifier: ["modkey"], key: "l"),
              (command: FocusWorkspacePrevious, value: "", modifier: ["modkey"], key: "h"),
              (command: MoveWindowUp, value: "", modifier: ["modkey", "Shift"], key: "Up"),
              (command: MoveWindowDown, value: "", modifier: ["modkey", "Shift"], key: "Down"),
              (command: FocusWindowUp, value: "", modifier: ["modkey"], key: "Up"),
              (command: FocusWindowDown, value: "", modifier: ["modkey"], key: "Down"),
              (command: NextLayout, value: "", modifier: ["modkey", "Control"], key: "Up"),
              (command: PreviousLayout, value: "", modifier: ["modkey", "Control"], key: "Down"),
              (command: FocusWorkspaceNext, value: "", modifier: ["modkey"], key: "Right"),
              (command: FocusWorkspacePrevious, value: "", modifier: ["modkey"], key: "Left"),
              (command: Execute, value: "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", modifier: [], key: "XF86XK_AudioMute"),
              (command: Execute, value: "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", modifier: [], key: "XF86XK_AudioRaiseVolume"),
              (command: Execute, value: "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", modifier: [], key: "XF86XK_AudioLowerVolume"),
              (command: Execute, value: "brightnessctl set +5%", modifier: [], key: "XF86XK_MonBrightnessUp"),
              (command: Execute, value: "brightnessctl set 5%-", modifier: [], key: "XF86XK_MonBrightnessDown"),
              (command: Execute, value: "xdotool key Menu", modifier: ["modkey"], key: "m"),
              (command: GotoTag, value: "1", modifier: ["modkey"], key: "1"),
              (command: GotoTag, value: "2", modifier: ["modkey"], key: "2"),
              (command: GotoTag, value: "3", modifier: ["modkey"], key: "3"),
              (command: GotoTag, value: "4", modifier: ["modkey"], key: "4"),
              (command: GotoTag, value: "5", modifier: ["modkey"], key: "5"),
              (command: GotoTag, value: "6", modifier: ["modkey"], key: "6"),
              (command: GotoTag, value: "7", modifier: ["modkey"], key: "7"),
              (command: GotoTag, value: "8", modifier: ["modkey"], key: "8"),
              (command: GotoTag, value: "9", modifier: ["modkey"], key: "9"),
              (command: MoveToTag, value: "1", modifier: ["modkey", "Shift"], key: "1"),
              (command: MoveToTag, value: "2", modifier: ["modkey", "Shift"], key: "2"),
              (command: MoveToTag, value: "3", modifier: ["modkey", "Shift"], key: "3"),
              (command: MoveToTag, value: "4", modifier: ["modkey", "Shift"], key: "4"),
              (command: MoveToTag, value: "5", modifier: ["modkey", "Shift"], key: "5"),
              (command: MoveToTag, value: "6", modifier: ["modkey", "Shift"], key: "6"),
              (command: MoveToTag, value: "7", modifier: ["modkey", "Shift"], key: "7"),
              (command: MoveToTag, value: "8", modifier: ["modkey", "Shift"], key: "8"),
              (command: MoveToTag, value: "9", modifier: ["modkey", "Shift"], key: "9"),
              (command: FloatingToTile, value: "", modifier: ["modkey"], key: "t"),
              (command: SetLayout, value: "MainAndVertStack", modifier: ["modkey"], key: "r"),
              (command: FocusNextTag, value: "", modifier: ["modkey"], key: "Next"),
              (command: FocusPreviousTag, value: "", modifier: ["modkey"], key: "Prior"),
              (command: IncreaseMainWidth, value: "5", modifier: ["modkey"], key: "d"),
              (command: DecreaseMainWidth, value: "5", modifier: ["modkey"], key: "a"),
              (command: ToggleFullScreen, value: "", modifier: ["modkey"], key: "e"),
              (command: ToggleScratchPad, value: "Terminal", modifier: ["modkey", "Shift"], key: "t"),
              (command: ToggleScratchPad, value: "Terminal", modifier: ["modkey"], key: "backslash"),
              (command: ToggleScratchPad, value: "Surf", modifier: ["modkey", "Shift"], key: "f"),
          ],
          workspaces: [
            (
              output: "DVI-I-1",
              x: 0,
              y: 0,
              width: 1680,
              height: 1050,
            ),
            (
              output: "HDMI-0",
              x: 1680,
              y: 0,
              width: 1920,
              height: 1200,
            )
          ],
          auto_derive_workspaces: false,
      )
    '';

    xdg.configFile."leftwm/up".source = "${(pkgs.writeShellScriptBin "leftwm_up" ''
      # pactl load-module \
          # module-null-sink \
          # media.class=Audio/Sink \
          # sink_name=RecordableAudio \
          # channel_map=stereo

      setxkbmap -option ctrl:nocaps

      unclutter &

      firefox &
      discord &
      # kitty -e nvlc ~/Music/Rock/ &
      # kitty -e python $HOME/scripts/macros.py &
      # kitty -e topgrade &
    '')}/bin/leftwm_up";
    xdg.configFile."leftwm/up".executable = true;
  };
}
