{
  pkgs,
  input,
  ...
}: {
  users.users.blackdragon2447 = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "input" "dailout"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      home-manager
    ];
  };
}
