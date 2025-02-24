{...}: {
  services.openssh = {
    enable = true;
    ports = [51005];
  };

  # networking.firewall.allowedTCPPorts = [51005];
}
