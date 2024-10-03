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
    version = "0.5.1";

    src = fetchFromGitHub {
      owner = "leftwm";
      repo = "leftwm";
      rev = "36609e0fcdfd131834b2ec9f1913211da6138ba1";
      hash = "sha256-ZoSZaNXxBLf8263GW7Cfbn7h1uW+GDSASbGCxl4u7mM=";
    };

    # cargoHash = "sha256-TylRxdpAVuGtZ3Lm8je6FZ0JUwetBi6mOGRoT2M3Jyk=";
    cargoHash = "sha256-O4AsuEyzgb8i8ixYP5mbxaSINELWl/93Ko+PigvPK5k=";

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
