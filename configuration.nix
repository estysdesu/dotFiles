{ config, pkgs, lib, ... }:
{
  imports = [ 
      ./configuration-base.nix
      ./machines/TSE-L502X-Pearson.nix
      ./roles/workstation.nix
  ];
  
  ########## ########## ########## ########## ########## 
  ########## STATE (OVERRIDE HERE)
  ########## ########## ########## ########## ########## 
  system.stateVersion = "20.03";
  system.autoUpgrade = lib.mkForce {
    enable = true;
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };
}
