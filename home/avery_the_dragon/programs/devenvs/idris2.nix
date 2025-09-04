{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.idris2.enable {
    home.packages = with pkgs; [
      idris2
      idris2Packages.pack
    ];
  };
}
