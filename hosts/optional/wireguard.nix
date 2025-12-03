{
  config,
  lib,
  secrets,
  ...
}:
{
  options = {
    hosts.enableWireguard = lib.mkEnableOption "enable wireguard";
  };

  config = lib.mkIf config.hosts.enableWireguard {
    networking.firewall = {
      allowedUDPPorts = [ 51820 ];
    };
    networking.wireguard.interfaces = {
      # wg0 = {
      #   ips = [ "192.168.69.3/24" ];
      #   listenPort = 51820;
      #
      #   privateKeyFile = "/etc/wireguard/privkey";
      #
      #   peers = [
      #     secrets.misc.wireguard-peer1
      #   ];
      # };
    };
  };
}
