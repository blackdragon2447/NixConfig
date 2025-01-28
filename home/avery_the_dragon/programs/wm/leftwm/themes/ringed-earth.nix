{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    wm.leftwm.themes.ringed-earth.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.wm.leftwm.themes.ringed-earth.enable {
    home.packages = with pkgs; [picom feh polybar];

    xdg.configFile."leftwm/themes/ringed-earth/theme.ron".text = ''
      #![enable(implicit_some)]
      (
          border_width: 0,
          margin: 10,
          workspace_margin: None,
          default_width: None,
          default_height: None,
          always_float: None,
          gutter: None,
          default_border_color: "#3d3b3c",
          floating_border_color: "#3d3b3c",
          focused_border_color: "#2cb8b5",
          on_new_window: None,
      )
    '';

    xdg.configFile."leftwm/themes/ringed-earth/up".text = ''
      #!/bin/sh
      SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
      export SCRIPTPATH
      $SCRIPTPATH/down

      #boot compton if it exists
      if [ -x "$(command -v picom)" ]; then
        picom --config $HOME/.config/picom.conf > /dev/null &
      fi

      #set background
      if [ -x "$(command -v feh)" ]; then
        feh --bg-fill "$SCRIPTPATH"/background.jpg
      fi

      if [ -x "$(command -v wired)" ]; then
        wired &> /dev/null &
      fi

      leftwm-command "LoadTheme $SCRIPTPATH/theme.ron"

      #boot polybar based on the number of monitors found
      # if [ -x "$(command -v polybar)" ]; then
      #   pkill polybar
      #   monitors="$(polybar -m | sed s/:.*// | tac)"
      #   while read -r display; do
      #     echo $display
      #     MONITOR=$display polybar -c "$SCRIPTPATH/polybar.config" mainbar &> /dev/null &
      #   done <<< "$monitors"
      #   exit 0
      # fi

      if [ -x "$(command -v wal)" ]; then
        wal -i "$SCRIPTPATH"/background.jpg -n
      fi

      if [ -x "$(command -v polybar)" ]; then
        pkill polybar
        MONITOR="DVI-I-1" polybar -c "$SCRIPTPATH/polybar.config" mainbar0 &> /dev/null &
        MONITOR="HDMI-0" polybar -c "$SCRIPTPATH/polybar.config" mainbar1 &> /dev/null &
        exit 0
      fi
    '';
    xdg.configFile."leftwm/themes/ringed-earth/up".executable = true;

    xdg.configFile."leftwm/themes/ringed-earth/down".text = ''
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
    xdg.configFile."leftwm/themes/ringed-earth/down".executable = true;

    xdg.configFile."leftwm/themes/ringed-earth/background.jpg".source = ./ringed-earth-files/background.jpg;
    xdg.configFile."leftwm/themes/ringed-earth/reset.jpg".source = ./reset.jpg;
    xdg.configFile."leftwm/themes/ringed-earth/polybar.config".source = ./ringed-earth-files/polybar.config;

    xdg.configFile."leftwm/themes/ringed-earth/template.liquid".text = ''
      {% for tag in workspace.tags %}
      {% if tag.mine %}
      %{u#04509b}%{+u}%{B#373B41} {{tag.name}} %{B-}%{u-}%{-u}
      {% elsif tag.visible  %}
      %{B#373B41} {{tag.name}} %{B-}
      {% elsif tag.busy %}
      %{B#373B41} {{tag.name}} %{B-}
      {% else tag.visible  %}
      %{F#FFFFFF} {{tag.name}} %{F-}
      {% endif %}
      {% endfor %}
       |
      {{ window_title | truncate: 40}}
    '';

    xdg.configFile."leftwm/themes/ringed-earth/polybar-mic.fish".text = ''
      #!${pkgs.fish}/bin/fish

      set muted (wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep MUTED)

      if [ -z $muted ]
          set volume (math 100 \* (wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | sed 's/.*\([0-9]\.[0-9][0-9]\).*/\1/'))
          set message (echo '%{F#04509b}MIC%{F-}' $volume%)
          echo $message
      else
          echo '%{F#707880}MIC muted%{F-}'
      end
    '';
    xdg.configFile."leftwm/themes/ringed-earth/polybar-mic.fish".executable = true;
  };
}
