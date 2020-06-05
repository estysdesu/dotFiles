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
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
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
      device = "/dev/disk/by-uuid/a7c7f043-f2bf-4ccf-b15e-447dd8ceba82";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0635-8914";
      fsType = "vfat";
    };
  };
  swapDevices = [ 
    { device = "/swapfile"; }
  ];

  ########## ########## ########## ########## ##########
  ########## NETWORKING
  ########## ########## ########## ########## ##########
  networking = {
    hostName = "TSE-OP790-Zane";
    useDHCP = false; # global flag is dep'd (per-instance useDHCP flag will be mandatory); therefore, explicitly set to false
    interfaces = {
      enp0s25.useDHCP = true;
      # wlp4s2.useDHCP = true;
    };
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}
