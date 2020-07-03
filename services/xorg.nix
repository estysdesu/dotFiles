{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # touchpad
   
    #displayManager.defaultSession = "plasma5";
    
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### AWESOME                             #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #windowManager.awesome.enable = true;
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### BSPWM                               #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #windowManager.bspwm = {
    #  enable = true;
    #  configFile = ../config/bspwm/bspwmrc;
    #  sxhkd.configFile = ../config/sxhkd/sxhkdrc;
    #  #configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/bspwmrc";
    #  #sxhkd.configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/sxhkdrc";
    #};
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### GNOME                               #####
    ##### ##### ##### ##### ##### ##### ##### #####
    #displayManager.gdm.enable = true;
    #desktopManager.gnome3.enable = true;
  
    ##### ##### ##### ##### ##### ##### ##### #####
    ##### KDE PLASME                          #####
    ##### ##### ##### ##### ##### ##### ##### #####
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
}
