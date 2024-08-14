{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.devenvs.rust.enable {
    home.packages = with pkgs; [rustup clang mold cargo-expand];

    home.file.".cargo/config.toml".text = ''
      [build]
      # linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';
  };
}
