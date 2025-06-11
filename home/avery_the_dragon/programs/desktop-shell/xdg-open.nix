{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
  };

  config = let
    firefox = "${pkgs.librewolf}/share/applications/firefox.desktop";
    vlc = "${pkgs.vlc}/share/applications/vlc.desktop";
    feh = "${pkgs.feh}/share/applications/feh.desktop";
  in {
    home-manager.users.avery_the_dragon = {
      xdg.mimeApps = {
        enabled = true;
        defaultApplications =
          {
            "text/html" = firefox;
            "x-scheme-handler/http" = firefox;
            "x-scheme-handler/https" = firefox;
            "x-scheme-handler/about" = firefox;
            "x-scheme-handler/unknown" = firefox;
            "image/png" = feh;
            "image/jpeg" = feh;
          }
          // lib.mkIf config.desktop.vlc.enable {
            "video/mp4" = vlc;
          };
      };
    };
  };
}
