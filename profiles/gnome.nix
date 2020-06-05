{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # touchpad
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
  };

  # environment.gnome3.excludePackages = [ ephiphany ];
  environment.systemPackages = with pkgs; [ firefox ];
}
