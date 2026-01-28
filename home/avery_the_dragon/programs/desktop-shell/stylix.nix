{ pkgs, ... }:
{
  config = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-sea.yaml";

      polarity = "dark";

      image = ./background.png;

      fonts = {
        serif = {
          package = pkgs.fira;
          name = "Fira Serif";
        };

        sansSerif = {
          package = pkgs.fira;
          name = "Fira Sans";
        };

        monospace = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font Mono";
        };
      };

      targets = {
        firefox.enable = false;

        librewolf = {
          enable = true;
          colorTheme.enable = true;
          profileNames = [ "avery_the_dragon" ];
        };

        gtk.enable = true;

        gnome.enable = false;
      };
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.dracula-icon-theme;
      };
    };

    home.packages = with pkgs; [ wpaperd ];
    xdg.configFile."wpaperd/config.toml".text = ''
      [default]
      mode = "center"

      [any]
      path = "${./background.png}"
    '';
  };
}
