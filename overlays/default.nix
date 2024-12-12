# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # python312Packages.dbus-next = prev.python312Packages.dbus-next.overrideAttrs (prev: {
    #   doCheck = false;
    # });
    python312Packages =
      prev.python312Packages
      // {
        dbus-next = prev.python312Packages.dbus-next.overrideAttrs (prev: {
          doCheck = false;
          doInstallCheck = false;
          dontCheck = true;
          disabledTests = ["test_sending_file_descriptor_low_level"] ++ prev.disabledTests;
        });
      };
    pass-secret-service = prev.pass-secret-service.overrideAttrs (prev: {
      doCheck = false;
    });
    xwayland-satellite = prev.xwayland-satellite.overrideAttrs (prev: {
      buildFeatures = prev.buildFeatures ++ ["systemd"];
    });
    rofi-calc = prev.rofi-calc.override {rofi-unwrapped = prev.rofi-wayland-unwrapped;};
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  niri = inputs.niri.overlays.niri;
}
