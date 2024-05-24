{
  pkgs,
  lib,
  config,
  ...
}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-medium
      paper
      setspace
      a4wide
      verbatimbox
      readarray
      forloop
      xypic
      tikz-qtree
      titlecaps
      xifthen
      dashbox
      ifnextok
      ifmtarg
      clipboard
      enumitem
      pgfplots
      latexindent
      ;
  };
in {
  config = lib.mkIf config.devenvs.tex.enable {
    home.packages = with pkgs; [tex mupdf rubber];
  };
}
