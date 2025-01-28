{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.c.enable {
    home.packages = with pkgs; [clang mold];
  };
}
