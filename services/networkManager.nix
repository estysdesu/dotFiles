{ config, pkgs, ... }:
{
    networking.networkmanager.enable = true; # wpa_supplicant is default wifi backend
}
