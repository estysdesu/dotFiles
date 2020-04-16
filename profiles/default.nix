{ config, pkgs, ... }:

{
  ########## ########## ########## ########## ##########
  ########## IMPORTS
  ########## ########## ########## ########## ##########
  imports = [ ];

  ########## ########## ########## ########## ##########
  ########## DEFAULT PACKAGES
  ########## ########## ########## ########## ##########
  environment.systemPackages = with pkgs; [
    bash
    zsh
    wget
    curl
    vim
    tmux
    git
    mkpasswd
    tree
  ];
  programs.zsh.enable = true;
}
