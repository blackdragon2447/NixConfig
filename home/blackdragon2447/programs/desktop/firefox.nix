{pkgs, lib, config, inputs, ...}: {

  options = {
    firefox.enable = lib.mkEnableOption "Enable Firefox";
    firefox.browserpass = lib.mkOption { description= "Enable browserpass for firefox"; };
  };

  config = lib.mkIf config.firefox.enable {
    programs.browserpass.enable = config.firefox.browserpass;
    programs.firefox = {
      enable = true;
      profiles.default-release = {
	extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
	  ublock-origin
	  # lib.mkIf config.firefox.browserpass browserpass
	  simple-tab-groups
	  user-agent-string-switcher
	  undoclosetabbutton
	  sponsorblock
	  ghostery
	  decentraleyes
	  clearurls
	  privacy-badger
	  rust-search-extension
	  consent-o-matic
	  canvasblocker
	  facebook-container
	  darkreader
	  old-reddit-redirect
	  terms-of-service-didnt-read
	] ++ (if config.firefox.browserpass then [inputs.packages.${pkgs.system}.browserpass] else []);
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };

}
