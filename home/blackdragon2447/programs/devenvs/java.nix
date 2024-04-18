{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.java.enable {
    programs.java = {
      enable = true;
      package = pkgs.jdk21.override {enableJavaFX = true;};
    };

    programs.gradle.enable = config.devenvs.java.enableGradle;
  };
}
