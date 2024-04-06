{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.java.enable {
    programs.java.enable = true;

    programs.gradle.enable = config.devenvs.java.enableGradle;
  };
}
