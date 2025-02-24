{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hosts.enableWireshark = lib.mkEnableOption "Enable Wireshark";
  };

  config = lib.mkIf config.hosts.enableWireshark {
    environment.systemPackages = [pkgs.wireshark];
    users.groups.wireshark = {};

    security.wrappers.dumpcap = {
      source = "${pkgs.wireshark}/bin/dumpcap";
      capabilities = "cap_net_raw,cap_net_admin+eip";
      owner = "root";
      group = "wireshark";
      permissions = "u+rx,g+x";
    };
  };
}
