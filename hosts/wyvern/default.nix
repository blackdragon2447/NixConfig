{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/users
    ../common
  ];

  networking = {
    hostName = "wyvern";
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    opengl.enable = true;
  };

  services.openssh = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
