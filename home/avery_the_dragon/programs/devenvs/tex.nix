{
  pkgs,
  lib,
  config,
  ...
}:
let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
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
      biblatex
      listings
      backnaur
      background
      everypage
      textpos
      latexindent
      moderncv
      scalerel
      stackengine
      svg
      csquotes
      epigraph
      nag
      todonotes
      rutitlepage
      nextpage
      newtx
      ebgaramond-maths
      ebgaramond
      svn-prov
      fontaxes
      tkz-orm
      rsfso
      tcolorbox
      biblatex-apa
      ;
    listings-rust = {
      pkgs = [ pkgs.listings-rust ];
    };
  };
in
{
  config = lib.mkIf config.devenvs.tex.enable {
    home.packages = with pkgs; [
      tex
      mupdf
      rubber
      biber
    ];
  };
}
