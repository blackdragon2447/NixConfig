{
  pkgs,
  lib,
  config,
  inputs,
  pkgs-stable,
  ...
}: {
  options = {
    desktop = {
      firefox.enable = lib.mkEnableOption "Enable Firefox";
      firefox.browserpass = lib.mkEnableOption "Enable browserpass for firefox";
    };
  };

  config = lib.mkIf config.desktop.firefox.enable {
    programs.browserpass.enable = config.desktop.firefox.browserpass;
    programs.librewolf = {
      enable = true;

      package = pkgs-stable.librewolf;

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisplayBookmarksToolbar = "always";
        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = false;
        };
        OfferToSaveLogins = false;
      };

      profiles.avery_the_dragon = {
        isDefault = true;

        search = {
          default = "ddg";
          engines = {
            "My Nixos" = {
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@mno"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "Nix Options" = {
              definedAliases = ["@no"];
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };
            "Rust Docs" = {
              definedAliases = ["@rs"];
              description = "A search engine for Rust";
              name = "Query.rs";
              urls = [
                {
                  template = "https://query.rs/redirect/{searchTerms}";
                }
                {
                  type = "application/x-suggestions+json";
                  template = "https://query.rs/suggest/{searchTerms}";
                }
              ];
            };
          };
        };

        extensions.force = true;
        extensions.packages = with inputs.firefox-addons.packages.${pkgs-stable.system};
          [
            ublock-origin
            # lib.mkIf config.firefox.browserpass browserpass
            simple-tab-groups
            sponsorblock
            ghostery
            decentraleyes
            # clearurls
            privacy-badger
            consent-o-matic
            canvasblocker
            facebook-container
            darkreader
            old-reddit-redirect
            terms-of-service-didnt-read
          ]
          ++ (
            if config.desktop.firefox.browserpass
            then [inputs.packages.${pkgs.system}.browserpass]
            else []
          );

        settings = {
          "browser.download.panel.shown" = true;
          "browser.download.useDownloadDir" = false;
          "browser.compactmode.show" = true;
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = ["librewolf.desktop"];
      "text/xml" = ["librewolf.desktop"];
      "x-scheme-handler/http" = ["librewolf.desktop"];
      "x-scheme-handler/https" = ["librewolf.desktop"];
    };
  };
}
