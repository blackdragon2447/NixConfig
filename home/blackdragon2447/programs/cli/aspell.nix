{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    cli.aspell.enable = lib.mkEnableOption "Enable aspell options";
  };
  config = lib.mkIf config.cli.aspell.enable {
    home.packages = with pkgs; [
      (aspellWithDicts (dicts: with dicts; [en en-computers en-science nl]))
    ];
  };
}
