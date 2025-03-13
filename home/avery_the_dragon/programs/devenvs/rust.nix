{
  config,
  lib,
  pkgs,
  secrets,
  ...
}: {
  config = lib.mkIf config.devenvs.rust.enable {
    home.packages = with pkgs; [rustup clang mold cargo-expand cargo-mommy];

    programs.fish.interactiveShellInit = ''
      ${secrets.misc.cargo_mommy_cfg}
    '';

    home.file.".cargo/config.toml".text = ''
      [target.x86_64-unknown-linux-gnu]
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';
  };
}
