{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.haskell.enable {
    home.packages = with pkgs; [stack ghc];
  };
}
