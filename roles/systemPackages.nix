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
    curl
    git
    mkpasswd
    tmux
    tree
    vim
    wget
  ];

}

