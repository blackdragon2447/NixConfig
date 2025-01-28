{...}: {
  fileSystems."/home/avery_the_dragon/Workspace/CoqWorkspace/SoftwareFoundations" = {
    device = "192.168.0.101:/SoftwareFoundations";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}
