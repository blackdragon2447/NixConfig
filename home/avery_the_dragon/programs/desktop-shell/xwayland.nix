{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop-shell.xwayland.enable = lib.mkEnableOption "Enable xwayland satellite xwayland support for compositors which dont support native xwayland";
  };

  config = lib.mkIf config.desktop-shell.xwayland.enable {
    home.packages = [pkgs.xwayland-satellite];
    # It won't notify systemd for some reason, so no service for us.
    # systemd.user.services.xwayland-satellite = {
    #   Unit = {
    #     Description = "Xwayland outside your Wayland";
    #     BindsTo = ["graphical-session.target"];
    #     PartOf = ["graphical-session.target"];
    #     After = ["graphical-session.target"];
    #     Requisite = ["graphical-session.target"];
    #   };
    #
    #   Service = {
    #     Type = "notify";
    #     NotifyAccess = "all";
    #     ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite :37";
    #     StandardOutput = "journal";
    #   };
    #
    #   Install = {
    #     WantedBy = ["graphical-session.target"];
    #   };
    # };
  };
}
