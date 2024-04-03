# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{inputs}: {
  # List your module files here
  # my-module = import ./my-module.nix;
  shellcolor = import ./shellcolor.nix;
  fonts = import ./fonts.nix;
  nixvim = inputs.nixvim.homeManagerModules.nixvim;
  nix-colors = inputs.nix-colors.homeManagerModules.default;
}
