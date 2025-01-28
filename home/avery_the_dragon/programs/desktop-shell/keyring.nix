{pkgs, ...}: {
  services.gnome-keyring.enable = false;
  home.packages = with pkgs.gnome; [gnome-keyring];
}
