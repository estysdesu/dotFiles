{ config, pkgs, ... }:
{
  imports = [
    ../profiles/sound.nix
    ../profiles/gnome.nix
    # ../profiles/virtualization.nix
    ../services/networkManager.nix
    ../services/plex.nix
    ../services/printing.nix
    ../services/qbittorrent.nix
    ../users/estysdesu.nix
    <home-manager/nixos>
  ];

  users.extraUsers.estysdesu.extraGroups = [ "networkmanager" "plex" "vboxusers" "docker"];
}
