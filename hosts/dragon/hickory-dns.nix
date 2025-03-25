{lib, ...}: let
  zone_dir = /var/lib/hickory-dns;
in {
  environment.systemPackages = [
    lib.writeTextFile
    {
      name = "local.zone";
      text = ''
        ORIGIN local.
        @                      3600 SOA   ns1.p30.dynect.net. (
                                      zone-admin.hydra1.local.     ; address of responsible party
                                      2016072701                 ; serial number
                                      3600                       ; refresh period
                                      600                        ; retry period
                                      604800                     ; expire time
                                      1800                     ) ; minimum ttl
        hydra1                      60 A     192.168.0.100
      '';
      executable = true;
      destination = "${zone_dir}/local.zone";
    }
  ];

  services.hickory-dns = {
    enable = true;
    settings = {
      zones."local." = {
        zone = "local";
      };
      directory = zone_dir;
    };
  };
}
