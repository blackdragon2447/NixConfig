{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.coq.enable {
    home.packages = with pkgs; [rocq-core rocqPackages.stdlib];
  };
}
