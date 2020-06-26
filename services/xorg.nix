{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # touchpad

    ##### ##### ##### ##### ##### ##### ##### #####
    ##### AWESOME                             #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #  displayManager.defaultSession = "none+awesome";
    #  windowManager.awesome.enable = true;
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### BSPWM                               #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #  #displayManager.defaultSession = "none+bspwm";
    #  displayManager.sddm.enable = true;
    #  windowManager.bspwm.enable = true;
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### GNOME                               #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #  displayManager.gdm.enable = true;
    #  desktopManager.gnome3.enable = true;
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### KDE PLASME                          #####
    ##### ##### ##### ##### ##### ##### ##### #####
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
