{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      cache_file = "/dev/null";
    };
  };

  home.packages = let
    inherit (config.desktop-shell.password-store) enable;
  in
    lib.optional enable pkgs.wofi-pass;
}
