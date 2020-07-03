{ config, pkgs, ... }:

{
  services.locate = {
    enable = true;
    interval = "00 01 * * *"; # daily @ 0100h
  };
}
