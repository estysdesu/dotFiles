{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    virtualbox
  ];

  virtualization.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
}
