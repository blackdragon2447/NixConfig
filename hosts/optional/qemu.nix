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
  };
}
