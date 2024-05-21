{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.coq.enable {
    programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
      Coqtail
    ];
  };
}
