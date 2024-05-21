{
  pkgs,
  config,
  lib,
  ...
}: let
  coq = pkgs.coq;
in {
  config = lib.mkIf config.devenvs.coq.enable {
    home.packages = [coq];
  };
}
