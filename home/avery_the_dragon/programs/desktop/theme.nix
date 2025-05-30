{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in rec {
  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.regular.family;
      size = 12;
    };
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme {scheme = config.colorscheme;};
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.dracula-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   name = "gtk2";
    #   package = pkgs.qt6Packages.qt6gtk2;
    # };
  };
}
