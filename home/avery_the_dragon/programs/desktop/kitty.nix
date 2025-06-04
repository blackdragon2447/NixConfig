{
  lib,
  config,
  ...
}: {
  options = {
    desktop.kitty = {
      enable = lib.mkEnableOption "Enable the kitty terminal";
    };
  };

  config = lib.mkIf config.desktop.kitty.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
