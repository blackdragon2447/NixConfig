{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.devenvs.coq.enable {
    home.packages = with pkgs; [
      (
        let
          rocqPkgs = rocqPackages_9_0;
        in
        (symlinkJoin {
          name = "rocq-dev-env";
          buildInputs = [ makeWrapper ];
          paths = with rocqPkgs; [
            rocq-core
          ];
          postBuild = ''
            LIB="${rocqPkgs.stdlib}/lib/coq/9.0/user-contrib"
            wrapProgram $out/bin/rocq \
              --set ROCQPATH $LIB
          '';
        })
      )
    ];
  };
}
