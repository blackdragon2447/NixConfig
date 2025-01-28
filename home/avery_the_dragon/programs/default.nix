{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cli
    ./desktop
    ./neovim
    ./wm
    ./desktop-shell
    ./devenvs
    ./games
  ];
}
