{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.colorscheme) palette;
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
          default_border_color: "#${palette.base02}",
          floating_border_color: "#${palette.base02}",
          focused_border_color: "#${palette.base08}",
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
        ${pkgs.imagemagick}/bin/convert -size 1x1 xc:#${palette.base00} "$SCRIPTPATH"/background.png
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
      [palette]
      background = #${palette.base01}
      background-alt = #${palette.base02}
      foreground = #${palette.base07}
      primary = #${palette.base09}
      secondary = #${palette.base08}
      alert = #A54242
      disabled = #${palette.base06}

      ${builtins.readFile ./system-files/polybar.config}
    '';

    xdg.configFile."leftwm/themes/system/template.liquid".text = ''
      {% for tag in workspace.tags %}
      {% if tag.mine %}
      %{o#${palette.base08}}%{+o}%{B#${palette.base04}} {{tag.name}} %{B-}%{o-}%{-o}
      {% elsif tag.visible  %}
      %{B#${palette.base03}} {{tag.name}} %{B-}
      {% elsif tag.busy %}
      %{B#${palette.base03}} {{tag.name}} %{B-}
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
          set message (echo '%{F#${palette.base08}}MIC%{F-}' $volume%)
          echo $message
      else
          echo '%{F#${palette.base06}}MIC muted%{F-}'
      end
    '';
    xdg.configFile."leftwm/themes/system/polybar-mic.fish".executable = true;

    xdg.configFile."leftwm/themes/system/polybar-vol.fish".text = ''
      #!${pkgs.fish}/bin/fish

      set muted (wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)

      if [ -z $muted ]
          set volume (math 100 \* (wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/.*\([0-9]\.[0-9][0-9]\).*/\1/'))
          set message (echo '%{F#${palette.base08}}VOL%{F-}' $volume%)
          echo $message
      else
          echo '%{F#${palette.base06}}VOL muted%{F-}'
      end
    '';
    xdg.configFile."leftwm/themes/system/polybar-vol.fish".executable = true;
  };
}
