{ config, pkgs, ... }:

{
  let with pkgs;
    qbittorrent-nox = qbittorrent.override { guiSupport = false; };
  in
    environment.systemPackages = [ qbittorrent-nox ];
}
      

