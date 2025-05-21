{
  pkgs,
  lib,
  config,
  inputs,
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
    programs.firefox = {
      enable = true;

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
            };
            "Rust Docs" = {
              definedAliases = ["@rs"];
              urls = [
                {
                  template = "https://doc.rust-lang.org/stable/std/";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system};
          [
            ublock-origin
            # lib.mkIf config.firefox.browserpass browserpass
            simple-tab-groups
            user-agent-string-switcher
            undoclosetabbutton
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
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };
}
