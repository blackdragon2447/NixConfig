{
  lib,
  stdenv,
  fetchFromSourcehut,
}: let
  pname = "macro-scipt";
in
  stdenv.mkDerivation {
    inherit pname;
    version = "0.1";
    src = [./macros.py];

    unpackPhase = ''
      for srcFile in $src; do
        # Copy file into build dir
        local tgt=$(echo $srcFile | cut --delimiter=- --fields=2-)
        cp $srcFile $tgt
      done
    '';
  }
