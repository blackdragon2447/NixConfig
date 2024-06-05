{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.rust.enable {
    home.packages = with pkgs; [rustup clang mold cargo-expand];
  };
}
