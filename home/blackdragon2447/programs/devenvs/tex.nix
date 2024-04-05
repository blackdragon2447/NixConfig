{
  pkgs,
  lib,
  config,
  ...
}: let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium paper setspace latexindent;
  };
in {
  config = lib.mkIf config.devenvs.tex.enable {
    home.packages = with pkgs; [tex mupdf rubber];
  };
}
