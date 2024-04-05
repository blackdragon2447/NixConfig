{lib, ...}: {
  imports = [
    ./fish.nix
    ./locale.nix
    ./nix.nix

    ./pipewire.nix
  ];

  pipewire.enable = lib.mkDefault true;

  programs.dconf.enable = true;

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.gpgSmartcards.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0407", ENV{ID_SECURITY_TOKEN}="1", GROUP="wheel"
  '';
}
