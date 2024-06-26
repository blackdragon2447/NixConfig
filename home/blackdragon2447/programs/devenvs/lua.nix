{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.lua.enable {
    home.packages = with pkgs; [(lua.withPackages (ps: with ps; [penlight]))];
  };
}
