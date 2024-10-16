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

      nvidia.acceptLicense = true;
    };
  };

  hardware.gpgSmartcards.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0407", ENV{ID_SECURITY_TOKEN}="1", GROUP="users"
  '';

  security.pam.services.swaylock = {};

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  /*
     security.pam.services.systemd-user.text = ''
    auth optional pam_group.so

    ${builtins.readFile "${pkgs.systemd}/etc/pam.d/systemd-user"}
  '';
  */
}
