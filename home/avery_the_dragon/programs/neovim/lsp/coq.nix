{
  lib,
  config,
  pkgs,
  ...
}: {
  config = let
    helpers = config.nixvim.helpers;
    keymap = import ../keymap.nix helpers;
  in
    lib.mkIf config.devenvs.coq.enable {
      programs.nixvim = {
        files."ftplugin/coq.lua".keymaps = keymap.coq;
        extraPlugins = with pkgs.neovimPlugins; [
          Coqtail
        ];
      };
    };
}
