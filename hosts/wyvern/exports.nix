{...}: {
  fileSystems = {
    "/export/SoftwareFoundations" = {
      device = "/home/avery_the_dragon/WorkSpaces/CoqWorkspace/SoftwareFoundations";
      options = ["bind"];
    };
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /export                     192.168.0.102(rw,fsid=0,no_subtree_check)
      /export/SoftwareFoundations 192.168.0.102(rw,nohide,insecure,no_subtree_check)
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];
}
