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
    systemd.user.services.macros = {
      Install = {
        WantedBy = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        # Group = "input";
        ExecStart = "${pkgs.writeShellScript "macros" ''
          export PATH="$PATH:${pkgs.lib.makeBinPath [pkgs.wireplumber]}"
          ${pkgs.python3.withPackages (python-pkgs: [python-pkgs.evdev])}/bin/python3 ${pkgs.macro-script}/bin/macros.py
        ''}";
      };
    };
  };
}
