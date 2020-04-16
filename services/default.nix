{ config, pkgs, ... }:

{
  imports = [
    ./locate.nix
    ./printing.nix
    ./sshd.nix
  ];
}
