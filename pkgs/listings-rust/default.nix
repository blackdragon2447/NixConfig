{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  name = "listings-rust";
  srcs = [
    (fetchFromGitHub {
      owner = "denki";
      repo = "listings-rust";
      rev = "d52a3d9211ee7e065e87b0e1c15af874aefc8848";
      sha256 = "sha256-BMzjrJRJ+T73dygjhdvusciHdmXpjbAcy4ZODjMLAMY=";
    })
  ];

  # dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/tex/latex
    cp listings-rust.sty $out/tex/latex
    runHook postInstall
  '';
  pname = name;
  tlType = "run";
}
