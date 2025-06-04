{lib, ...}: {
  imports = [
    ./waybar.nix
    ./menu.nix
    ./swaylock.nix
    ./wofi.nix
    ./password-store.nix
    # ./keyring.nix
    ./macro-pad.nix
    ./notify.nix
    ./xwayland.nix
    ./stylix.nix
  ];

  services.gnome-keyring.enable = lib.mkForce false;
}
