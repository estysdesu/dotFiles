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
      availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
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
    "/boot" = {
      device = "/dev/disk/by-uuid/C652-2517";
      fsType = "vfat";
    };
    "/" = { 
      device = "/dev/disk/by-uuid/dbba4ed2-ab18-424a-8a29-2514aa3ac0f1";
      fsType = "ext4";
    };
    "/data" = { 
      device = "/dev/disk/by-uuid/a2aeed8d-eab9-4885-9ad1-b63653b6f29a";
      fsType = "ext4";
    };
  };
  swapDevices = [ 
    { device = "/dev/disk/by-uuid/960d7df7-768f-4769-9f50-6b7d86288fc2"; }
  ];

  ########## ########## ########## ########## ##########
  ########## NETWORKING
  ########## ########## ########## ########## ##########
  networking = {
    hostName = "TSE-E6320-Williams";
    useDHCP = false; # global flag is dep'd (per-instance useDHCP flag will be mandatory); therefore, explicitly set to false
    interfaces = {
      eno1.useDHCP = true;
      wlp2s0.useDHCP = true;
    };
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };

  ########## ########## ########## ########## ##########
  ########## SOUND
  ########## ########## ########## ########## ##########
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  ########## ########## ########## ########## ##########
  ########## BLUETOOTH
  ########## ########## ########## ########## ##########
  hardware.bluetooth.enable = true;

}

