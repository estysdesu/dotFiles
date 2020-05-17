{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # touchpad
    displayManager.defaultSession = "none+awesome";
    windowManager.awesome.enable = true;
  };
}
