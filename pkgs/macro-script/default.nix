{
  lib,
  stdenv,
  pkgs,
}: let
  pname = "macro-scipt";
in
  stdenv.mkDerivation {
    inherit pname;
    version = "0.1";
    src = [];
    buildInputs = with pkgs; [
      (pkgs.python3.withPackages (python-pkgs: [python-pkgs.evdev]))
    ];
    nativeBuildInputs = with pkgs; [
      alsa-utils
    ];
    dontUnpack = true;

    buildPhase = ''
      install -Dm755 ${./macros.py} $out/bin/macros.py
    '';
  }
