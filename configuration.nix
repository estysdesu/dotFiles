# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ########## ########## ########## ########## ########## 
  ########## IMPORTS
  ########## ########## ########## ########## ########## 
  imports = [ 
      ./hardware-configuration.nix
      ./configuration-base.nix
      ./machines/TSE-OP990-Nix.nix
  ];
  
  ########## ########## ########## ########## ########## 
  ########## STATE (OVERRIDE HERE)
  ########## ########## ########## ########## ########## 
  system.stateVersion = "20.03";
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-20.03";
  };
}

