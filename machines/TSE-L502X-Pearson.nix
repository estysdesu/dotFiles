{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  ########## ########## ########## ########## ##########
  ########## BOOT
  ########## ########## ########## ########## ##########
  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
    };
    initrd = {
      availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest; # latest kernel
    cleanTmpDir = true;
  };

  ########## ########## ########## ########## ##########
  ########## FILESYSTEMS
  ########## ########## ########## ########## ##########
  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/e4f33b12-9564-40e5-8ec7-497e1694c0a9";
      fsType = "ext4";
    };
    "/data" = { 
      device = "/dev/disk/by-uuid/37af03f8-e1ce-4ee0-89ec-bd40833aa859";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/90b20459-2889-4e01-8876-2b2cc7e5d8c4";
      fsType = "ext4";
    };
  };
  swapDevices = [ 
    { device = "/dev/disk/by-uuid/c108bc67-b0c3-4b80-8682-d4fd88bd785c"; }
  ];

  ########## ########## ########## ########## ##########
  ########## NETWORKING
  ########## ########## ########## ########## ##########
  networking = {
    hostName = "TSE-L502X-Pearson";
    useDHCP = false; # global flag is dep'd (per-instance useDHCP flag will be mandatory); therefore, explicitly set to false
    interfaces = {
      enp6s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}


