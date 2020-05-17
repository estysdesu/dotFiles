{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # environment.systemPackages = with pkgs; [
  #   virtualboxWithExtpack
  # ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
}
