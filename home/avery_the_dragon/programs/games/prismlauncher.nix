{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    games.prismlauncher.enable = lib.mkEnableOption "Enable the prismlauncher minecraft launcher";
  };

  config = lib.mkIf config.games.prismlauncher.enable {
    home.packages = with pkgs; [prismlauncher];
  };
}
