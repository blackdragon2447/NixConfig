{...}: {
  services.openssh = {
    enable = true;
    ports = [22 22220 2221 51005];
    extraConfig = ''
      ClientAliveInterval 300
      ClientAliveCountMax 10
    '';
  };

  networking.firewall.allowedTCPPorts = [22 22220 22221 51005];
}
