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
  ];
}
