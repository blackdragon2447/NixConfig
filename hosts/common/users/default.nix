{
  pkgs,
  input,
  ...
}: {
  users.users.avery_the_dragon = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = ["wheel" "video" "input" "dailout" "plugdev"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      home-manager
    ];
  };
}
