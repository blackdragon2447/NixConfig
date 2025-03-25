{pkgs, ...}: {
  imports = [
    ./hydra1-hardware.nix
    ./hydra-common.nix

    ./config/postfix.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "hydra1"; # Define your hostname.

  system.stateVersion = "25.05"; # Did you read the comment?
}
