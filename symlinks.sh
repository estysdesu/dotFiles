#!/usr/bin/env bash

##### set symlinks for dotFiles #####
# Alacritty
#ln -sf $HOME/dotFiles/alacritty/.alacritty.yml $HOME/
# Bash
ln -sf $HOME/dotFiles/bash/{.bash_profile,.bashrc,.profile} $HOME/
# Bin [user]
ln -sfFn $HOME/dotFiles/bin $HOME/bin
# Git
ln -sf $HOME/dotFiles/git/.gitignore_global $HOME/
# GMSH
#ln -sf $HOME/dotFiles/gmsh/{.gmshrc,.gmsh-options} $HOME/
# Lepton
#ln -sf $HOME/dotFiles/lepton/.leptonrc $HOME/
# Neofetch
ln -sf $HOME/dotFiles/neofetch/config.conf $HOME/.config/neofetch/
# Tmux
ln -sf $HOME/dotFiles/tmux/.tmux.conf $HOME/
# Vim -- manual since contents are going multiple directories
ln -sf $HOME/dotFiles/vim/.vimrc $HOME/ 
ln -sfFn $HOME/dotFiles/vim/myPlugins $HOME/.vim/myPlugins 
# VS Code
#ln -sf $HOME/dotFiles/vscode/{settings.json,keybindings.json} "$HOME/Library/Application Support/Code/User/"
#ln -sfn $HOME/dotFiles/vscode/snippets "$HOME/Library/Application Support/Code/User/snippets"
#sh $HOME/dotFiles/vscode/sharedConfig.sh
