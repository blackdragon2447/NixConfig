{...}: {
  systemd.network = {
    enable = true;

    networks."10-lan" = {
      matchConfig.Name = ["eno1" "vm*"];
      networkConfig = {
        Bridge = "br0";
      };
    };

    netdevs."br0" = {
      netdevConfig = {
        Name = "br0";
        Kind = "bridge";
      };
    };

    netdevs."vm-hydra1" = {
      netdevConfig = {
        Name = "vmhydra1";
        Kind = "tap";
      };
    };

    netdevs."vm-hydra2" = {
      netdevConfig = {
        Name = "vmhydra2";
        Kind = "tap";
      };
    };

    networks."10-lan-bridge" = {
      matchConfig.Name = "br0";
      networkConfig = {
        Address = ["192.168.0.102/24" "fe80::5322:615b:ff6c:c83c/64"];
        Gateway = "192.168.0.1";
        DNS = "192.168.0.1";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
}
