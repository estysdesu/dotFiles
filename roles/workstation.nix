{ config, pkgs, ... }:
{
  imports = [
    ../sysPackages.nix
    ../x11SysPackages.nix
    ../services/networkManager.nix
    #../services/plex.nix
    ../services/printing.nix
    #../services/qbittorrent.nix
    ../services/xorg.nix
    ../users/estysdesu.nix
  ];

  users.extraUsers.estysdesu.extraGroups = [ "networkmanager" "plex" "vboxusers" "docker" ];

  fonts.fonts = with pkgs; [
    font-awesome
  ];

}
