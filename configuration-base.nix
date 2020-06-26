{ config, lib, pkgs, ... }:

{
  ########## ########## ########## ########## ##########
  ########## IMPORTS
  ########## ########## ########## ########## ##########
  imports = [
    ./services/default.nix
    ./users/estysdesu.nix
  ];

  ########## ########## ########## ########## ########## 
  ########## STATE
  ########## ########## ########## ########## ########## 
  system = {
    stateVersion = "20.03";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://nixos.org/channels/nixos-20.03";
    };
    copySystemConfiguration = true; # cp /etc/nixos/configuration.nix /run/current-system/configuration.nix (ln -s ?)
  };

  ########## ########## ########## ########## ########## 
  ########## NIX
  ########## ########## ########## ########## ########## 
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    buildCores = 2; # speed up dev at cost of possible build race conditions
    maxJobs = lib.mkDefault 2;
  };

  ########## ########## ########## ########## ##########
  ########## NIXPKGS
  ########## ########## ########## ########## ##########
  nixpkgs.config.allowUnfree = true;

  ########## ########## ########## ########## ##########
  ########## LANGUAGE & TIME
  ########## ########## ########## ########## ##########
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  time.timeZone = "America/Indiana/Indianapolis";
 
  ########## ########## ########## ########## ##########
  ########## SECURITY
  ########## ########## ########## ########## ##########
   security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  ########## ########## ########## ########## ##########
  ########## POWER MANAGEMENT
  ########## ########## ########## ########## ##########
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
