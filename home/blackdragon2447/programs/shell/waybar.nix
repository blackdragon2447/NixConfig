{ pkgs, lib, config, ... }: {
  
  options = {
    # shell.
    waybar.enable = lib.mkEnableOption "enable waybar";
  };
  
  config = lib.mkIf config.waybar.enable {
    progams.waybar = {
      enable = true;

      settings = {
        modules-left = [ "river/tags" "river/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "memory" "cpu" "wireplumber" "battery" "network" ];

        "river/window".max-length = 50;

        network = {
          interface = "wlp170s0";
          format-wifi = "  {ifname} {essid} {ipaddr}";
        };
      };
    };
  };

}
