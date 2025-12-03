{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.devenvs.java.enable {
    programs.java = {
      enable = true;
      package = pkgs.jdk21.override {enableJavaFX = false;};
    };

    programs.gradle.enable = config.devenvs.java.enableGradle;
  };
}
