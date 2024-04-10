{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  options = {
    wm.leftwm.themes.system.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.wm.leftwm.themes.system.enable {
    home.packages = with pkgs; [feh polybar];

    xdg.configFile."leftwm/themes/system/theme.ron".text = ''
      #![enable(implicit_some)]
      (
          border_width: 1,
          margin: 6,
          workspace_margin: None,
          default_width: None,
          default_height: None,
          always_float: None,
          gutter: None,
          default_border_color: "#${colors.base02}",
          floating_border_color: "#${colors.base02}",
          focused_border_color: "#${colors.base08}",
          on_new_window: None,
      )
    '';

    xdg.configFile."leftwm/themes/system/up".text = ''
      #!/bin/sh
      SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
      export SCRIPTPATH
      $SCRIPTPATH/down

      #set background
      if [ -x "$(command -v feh)" ]; then
        ${pkgs.imagemagick}/bin/convert -size 1x1 xc:#${colors.base00} "$SCRIPTPATH"/background.png
        sleep 1
        feh --bg-scale "$SCRIPTPATH"/background.png
      fi

      leftwm-command "LoadTheme $SCRIPTPATH/theme.ron"

      if [ -x "$(command -v polybar)" ]; then
        pkill polybar
        MONITOR="DVI-I-1" polybar -c "$SCRIPTPATH/polybar.config" mainbar0 &> /dev/null &
        MONITOR="HDMI-0" polybar -c "$SCRIPTPATH/polybar.config" mainbar1 &> /dev/null &
        exit 0
      fi
    '';
    xdg.configFile."leftwm/themes/system/up".executable = true;

    xdg.configFile."leftwm/themes/system/down".text = ''
      #!/bin/sh

      SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

      #set background
      if [ -x "$(command -v feh)" ]; then
        feh --bg-scale $SCRIPTPATH/reset.jpg
      fi

      echo "UnloadTheme" > $XDG_RUNTIME_DIR/leftwm/commands.pipe

      pkill compton
      pkill polybar
    '';
    xdg.configFile."leftwm/themes/system/down".executable = true;

    xdg.configFile."leftwm/themes/system/reset.jpg".source = ./reset.jpg;

    xdg.configFile."leftwm/themes/system/polybar.config".text = ''
      [colors]
      background = #${colors.base01}
      background-alt = #${colors.base02}
      foreground = #${colors.base07}
      primary = #${colors.base09}
      secondary = #${colors.base08}
      alert = #A54242
      disabled = #${colors.base06}

      ${builtins.readFile ./system-files/polybar.config}
    '';

    xdg.configFile."leftwm/themes/system/template.liquid".text = ''
      {% for tag in workspace.tags %}
      {% if tag.mine %}
      %{o#${colors.base08}}%{+o}%{B#${colors.base04}} {{tag.name}} %{B-}%{o-}%{-o}
      {% elsif tag.visible  %}
      %{B#${colors.base03}} {{tag.name}} %{B-}
      {% elsif tag.busy %}
      %{B#${colors.base03}} {{tag.name}} %{B-}
      {% else tag.visible  %}
      %{F#FFFFFF} {{tag.name}} %{F-}
      {% endif %}
      {% endfor %}
       |
      {{ window_title | truncate: 40}}
    '';

    xdg.configFile."leftwm/themes/system/polybar-mic.fish".text = ''
      #!${pkgs.fish}/bin/fish

      set muted (wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep MUTED)

      if [ -z $muted ]
          set volume (math 100 \* (wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | sed 's/.*\([0-9]\.[0-9][0-9]\).*/\1/'))
          set message (echo '%{F#${colors.base08}}MIC%{F-}' $volume%)
          echo $message
      else
          echo '%{F#${colors.base06}}MIC muted%{F-}'
      end
    '';
    xdg.configFile."leftwm/themes/system/polybar-mic.fish".executable = true;
  };
}
