{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
in
{
  options = {
    cli.fish.enable = lib.mkEnableOption "Enable fish options";
  };

  config = lib.mkIf config.cli.fish.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ga = "git add .";
        gs = "git status";
        gm = "git commit -S -m";
        gam = "git add . && git commit -S -m";
        gp = "git push origin $(git branch --show-current)";

        which = "command -v";

        # TODO: Hibernate etc
      };
      shellAliases = {
        ls = "eza -la --icons";
        cat = "bat";
        grep = "rg";
        find = "fd";
        icat = mkIf (hasPackage "kitty") "kitty +kitten icat";

        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
        q = "exit";

        woman = "man";
      };

      functions = {
        fish_greeting = "pfetch";
      };

      interactiveShellInit = ''
        bind \e\[3\;5~ kill-word
        bind \cH backward-kill-word
      '';

      plugins = [
        {
          name = "done.fish";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "998ad4f5fc9cee36c09840a7e635b56428e554f9";
            hash = "sha256-GZ1ZpcaEfbcex6XvxOFJDJqoD9C5out0W4bkkn768r0=";
          };
        }
      ];
    };
  };
}
