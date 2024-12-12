{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font Mono";
      package = pkgs.nerd-fonts.hack;
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };

  home.packages = with pkgs; [
    font-awesome
    roboto
  ];
}
