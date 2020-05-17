{ config, pkgs, ... }:
{
  imports = [ 
      ./configuration-base.nix
      ./machines/TSE-OP790-Zane.nix
      ./roles/workstation.nix
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
