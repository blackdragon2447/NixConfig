{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop-shell.password-store.enable = lib.mkEnableOption "Enable the unix pass tool";
  };

  config = lib.mkIf config.desktop-shell.password-store.enable {
    programs.password-store = {
      enable = true;
      settings = {PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";};
    };

    services.pass-secret-service = {
      enable = true;
      storePath = "${config.home.homeDirectory}/.password-store";
    };

    # home.packages = with pkgs; [pass-secret-service];
  };
}
