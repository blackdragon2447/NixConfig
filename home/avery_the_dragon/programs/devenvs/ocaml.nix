{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.ocaml.enable {
    home.packages = with pkgs; [
      ocaml
    ];
  };
}
