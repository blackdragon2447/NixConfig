{lib, ...}: {
  i18n = {
    extraLocaleSettings = {
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  time.timeZone = lib.mkDefault "Europe/Amsterdam";
}
