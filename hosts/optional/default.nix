{...}: {
  imports = [
    ./docker.nix
    ./bluetooth.nix
    ./brightness.nix
    ./printing.nix
    ./qemu.nix
    ./ssh.nix
    ./games.nix
    ./wireshark.nix
    ./xorg.nix
    ./wireguard.nix
  ];
}
