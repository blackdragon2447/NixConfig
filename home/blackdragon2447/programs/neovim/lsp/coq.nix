{
  lib,
  config,
  pkgs,
  ...
}: {
  config = let
    keymap = import ../keymap.nix;
  in
    lib.mkIf config.devenvs.coq.enable {
      programs.nixvim = {
        files."ftplugin/coq.lua".keymaps = keymap.coq;
        extraPlugins = with pkgs.vimPlugins; [
          Coqtail
        ];
      };
    };
}
