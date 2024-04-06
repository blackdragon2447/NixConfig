{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font";
      package = pkgs.nerdfonts;
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
