{ config, pkgs, ... }:

{
  imports = [ ];

  ########## ########## ########## ########## ##########
  ########## BOOT
  ########## ########## ########## ########## ##########
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  ########## ########## ########## ########## ##########
  ########## NETWORKING
  ########## ########## ########## ########## ##########
  networking.hostName = "TSE-OP990-NIX";
  networking.useDHCP = false; # global flag is dep'd (per-instance useDHCP flag will be mandatory); therefore, explicitly set to false
  networking.interfaces.eno1.useDHCP = true;
  # networking.interfaces.wlp2s0.useDHCP = true;
  networking.networkmanager.enable = true; # wpa_supplicant is default wifi backend
  
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  ########## ########## ########## ########## ##########
  ########## BUILD CORES
  ########## ########## ########## ########## ##########
  nix.buildCores = 2; # speed up development at cost of possible build race conditions
}
