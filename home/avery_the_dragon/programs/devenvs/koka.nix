{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.koka.enable {
    home.packages = with pkgs; [
      koka
    ];
  };
}
