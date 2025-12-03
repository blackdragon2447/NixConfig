{ lib, ... }:
{
  imports = [
    ./fish.nix
    ./locale.nix
    ./nix.nix

    ./pipewire.nix
    ./network.nix
  ];

  pipewire.enable = lib.mkDefault true;

  programs.dconf.enable = true;

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;

      nvidia.acceptLicense = true;
    };
  };

  nix.settings = {
    use-xdg-base-directories = true;
  };

  hardware.gpgSmartcards.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0407", ENV{ID_SECURITY_TOKEN}="1", GROUP="users"
  '';

  security.pam.services.swaylock = { };
  services.fprintd.enable = false;

  services.pcscd.enable = true;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    GOPATH = "$XDG_DATA_HOME/go";
    GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
    GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}
