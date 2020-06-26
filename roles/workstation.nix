{ config, pkgs, ... }:
{
  imports = [
    ./systemPackages.nix
    ../services/networkManager.nix
    #../services/plex.nix
    ../services/printing.nix
    #../services/qbittorrent.nix
    ../services/xorg.nix
    ../users/estysdesu.nix
  ];

  users.extraUsers.estysdesu.extraGroups = [ "networkmanager" "plex" "vboxusers" "docker" ];

  environment.systemPackages = with pkgs; [
    firefox
  ];

}
