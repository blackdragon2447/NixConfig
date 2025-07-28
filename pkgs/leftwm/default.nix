{
  lib,
  fetchFromGitHub,
  rustPlatform,
  libX11,
  libXinerama,
}: let
  rpathLibs = [libXinerama libX11];
in
  rustPlatform.buildRustPackage rec {
    pname = "leftwm";
    version = "0.5.4";

    src = fetchFromGitHub {
      owner = "leftwm";
      repo = "leftwm";
      rev = "9a1a2f8d835969236d0ece472e02450c533d6c22";
      hash = "sha256-ZoSZaNXxBLf8263GW7Cfbn7h1uW+GDSASbGCxl4u7mM=";
    };

    cargoHash = "sha256-0tGIRcmVLMRKonlTxhGT1YpshMi+p4SIL2UnDxLxzZU=";

    buildInputs = rpathLibs;

    postInstall = ''
      for p in $out/bin/left*; do
        patchelf --set-rpath "${lib.makeLibraryPath rpathLibs}" $p
      done

      install -D -m 0555 leftwm/doc/leftwm.1 $out/share/man/man1/leftwm.1
    '';

    dontPatchELF = true;

    meta = {
      description = "A tiling window manager for the adventurer";
      homepage = "https://github.com/leftwm/leftwm";
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [yanganto];
      changelog = "https://github.com/leftwm/leftwm/blob/${version}/CHANGELOG.md";
      mainProgram = "leftwm";
    };
  }
