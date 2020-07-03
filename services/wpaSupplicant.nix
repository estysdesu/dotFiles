{ config, pkgs, ... }:
{
  networking.wireless.enable = true;
  environment.systemPackages = with pkgs; [
    wpa_supplicant # wpa_supplicant -B -i <interface> -c <(wpa_passphrase '<ssid>' '<passphrase>')
  ]
}
