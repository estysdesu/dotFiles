# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
    ];

  ##### STATE #####
  # NixOS release with which your system is to be compatible
  system.stateVersion = "19.09"; 

  ##### BOOT #####
  # Systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### LANG & TIME #####  
  # Internationalisation
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  # Timezone 
  time.timeZone = "America/Indianapolis";

  ##### NETWORKING #####
  networking.hostName = "TSE-LAT_E6320-NIX"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # enables wireless support via wpa_supplicant; networkmanager uses this as wifi backend
  networking.useDHCP = false; # The global useDHCP flag is deprecated, therefore explicitly set to false here
  networking.interfaces.eno1.useDHCP = true; # Per-interface useDHCP will be mandatory in the future
  networking.interfaces.wlp2s0.useDHCP = true; # Per-interface useDHCP will be mandatory in the future

  ##### PACKAGES #####
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
    if config.services.xserver.enable then
      [ wget vim tmux git mkpasswd plexmediaserver mkpasswd firefox teamviewer ]
    else [ wget vim tmux git mkpasswd plexmediaserver ];

  ##### SERVICES #####

  # OpenSSH
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  # Firewall
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  
  # Plex
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # Printing
  services.printing.enable = true; # Enable CUPS to print documents.

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # touchpad
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
  };

  # Packages to exclude from Gnome
  environment.gnome3.excludePackages = [
    pkgs.gnome3.epiphany
  ];

  ##### USERS #####
  # users.motd = [ "User: $(whoami)" "Hostname $(hostname -s)" ]
  users.users.estysdesu = {
    isNormalUser = true; # group = "users"; createHome = true; home = "home/<username>"; useDefaultShell = true; isSystemUser = false;
    description = "Tyler Estes";
    extraGroups = [ "wheel" "networkmanager" "plex" ]; 
    initialHashedPassword = "4w/N25YtiU0qHLU7$3xINv36PynvKcXxDV88MiScA93ocwr1AC.j9NYDDFkLnft8zKCqBQo2NTOetQvgjE0OKVMX7Y5D.z8ssrhx7w1";
  };
}
