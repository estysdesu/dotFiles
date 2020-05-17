{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; 
  let
    qbittorrent-nox = qbittorrent.override { guiSupport = false; };
  in 
    [ qbittorrent-nox ];

#   environment.systemPackages = [ qbittorrent-nox ];
}
      

