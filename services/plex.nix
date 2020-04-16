{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ plex ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
