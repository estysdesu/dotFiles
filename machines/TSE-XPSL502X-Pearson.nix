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
      # systemd-boot.enable = true;
      # efi.canTouchEfiVariables = true;
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
      device = "/dev/mapper/vg01-root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/<xxx>";
      fsType = "ext4";
    };
  };
  swapDevices = [ {
    device = "/dev/mapper/vg01-swap";
    size = 8192; # MiB
  } ];

  ########## ########## ########## ########## ##########
  ########## NETWORKING
  ########## ########## ########## ########## ##########
  networking = {
    hostName = "TSE-XPSL502X-Pearson";
    useDHCP = false; # global flag is dep'd (per-instance useDHCP flag will be mandatory); therefore, explicitly set to false
    interfaces = {
      # enp0s25.useDHCP = true; # TODO: CHECK
      wlp3s0.useDHCP = true;
    };
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}
