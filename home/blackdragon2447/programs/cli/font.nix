{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["Hack"];};
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
