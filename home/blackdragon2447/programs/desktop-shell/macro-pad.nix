{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop-shell.macro-pad.enable = lib.mkEnableOption "Enable the macro-pad";
  };

  config = lib.mkIf config.desktop-shell.macro-pad.enable {
    home.packages = [pkgs.python311Packages.evdev];

    systemd.user.services.macros = {
      Install = {
        WantedBy = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "macros" ''
          ${pkgs.python3}/bin/python3 ~/scripts/macros.py
        ''}";
      };
    };
  };
}
