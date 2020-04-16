{ config, pkgs, ... }:

{
  ########## ########## ########## ########## ##########
  ########## IMPORTS
  ########## ########## ########## ########## ##########
  imports = [
    ./profiles/default.nix
    ./services/default.nix
    ./users/estysdesu.nix
  ];

  ########## ########## ########## ########## ########## 
  ########## STATE
  ########## ########## ########## ########## ########## 
  system.stateVersion = "20.03";
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-20.03";
  };

  ########## ########## ########## ########## ########## 
  ########## NIX
  ########## ########## ########## ########## ########## 
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  ########## ########## ########## ########## ##########
  ########## LANGUAGE & TIME
  ########## ########## ########## ########## ##########
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.console.Font = "Lat2-Terminus16";
  i18n.console.keyMap = "us";
  time.timeZone = "America/Indianapolis";
}
