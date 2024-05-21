{
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.pipewire = {
    wireplumber = {
      # extraLuaConfig.main."10-loopback" = ''
      #   auto_connect_ports {
      #     output = Constraint { "object.path", "matches", "alsa:pcm:2:front:2:capture:capture_*" },
      #     input = Constraint { "object.path", "matches", "mic_loopback_sink:playback_*" },
      #     connect = {
      #       ["FL"] = "FL",
      #       ["FR"] = "FR",
      #     },
      #   }
      # '';
    };

    extraConfig.pipewire = {
      "98-input-denoising" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "Noise Canceling source";
              "media.name" = "Noise Canceling source";
              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                    label = "noise_suppressor_mono";
                    control = {
                      "VAD Threshold (%)" = 95.0;
                      "VAD Grace Period (ms)" = 200;
                      "Retroactive VAD Grace (ms)" = 0;
                    };
                  }
                ];
              };
              "capture.props" = {
                "node.name" = "capture.rnnoise_source";
                "node.passive" = true;
                "audio.rate" = 24000;
              };
              "playback.props" = {
                "node.name" = "rnnoise_source";
                "media.class" = "Audio/Source";
                "audio.rate" = 24000;
              };
            };
          }
        ];
      };
      "99-microphone-loopback" = {
        "context.modules" = [
          {
            name = "libpipewire-module-loopback";
            args = {
              "audio.position" = ["FL" "FR"];
              "capture.props" = {
                "media.class" = "Audio/Sink";
                "node.name" = "mic_loopback_sink";
                "node.description" = "mic loopback sink";
                "node.latency" = "48/36000";
                #audio.rate = 44100
                #audio.channels = 2
                #audio.position = [ FL FR ]
                #target.object = "USB Advanced Audio Device Analog Stereo"
              };
              "playback.props" = {
                #"media.class" = Audio/Source
                "node.name" = "mic_loopback_source";
                "node.description" = "mic loopback source";
                "node.latency" = "48/36000";
                #audio.rate = 44100
                #audio.channels = 2
                #audio.position = [ FL FR ]
                #target.object = "Starship/Matisse HD Audio Controller Analog Stereo"
              };
            };
          }
        ];
      };
    };
  };
}
