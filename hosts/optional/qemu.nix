{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hosts.enableQemu = lib.mkEnableOption "Enable Qemu";
  };

  config = lib.mkIf config.hosts.enableQemu {
    environment = {
      systemPackages = with pkgs; [qemu quickemu];
    };
    systemd.tmpfiles.rules = ["L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"];

    systemd.network = {
      enable = true;

      networks."10-lan" = {
        matchConfig.Name = ["eno1" "vm-*"];
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

      netdevs."tap0" = {
        netdevConfig = {
          Name = "tap0";
          Kind = "tap";
        };
      };

      netdevs."tap1" = {
        netdevConfig = {
          Name = "tap1";
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

      networks."10-tap0" = {
        matchConfig.Name = "tap0";
        networkConfig = {
          Bridge = "br0";
        };
      };

      networks."10-tap1" = {
        matchConfig.Name = "tap1";
        networkConfig = {
          Bridge = "br0";
        };
      };
    };
  };
}
