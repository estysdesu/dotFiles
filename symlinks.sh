#!/usr/bin/env bash

##### set symlinks for dotFiles #####

##### Alacritty #####
ln -sf $HOME/dotFiles/alacritty/.alacritty.yml $HOME/

##### Bash #####
ln -sf $HOME/dotFiles/bash/.bash_profile $HOME/
ln -sf $HOME/dotFiles/bash/.bashrc $HOME/
ln -sf $HOME/dotFiles/bash/.profile $HOME/

##### Bin [user] #####
ln -sf $HOME/dotFiles/bin $HOME/bin

##### Git #####
ln -sf $HOME/dotFiles/git/.gitignore_global $HOME/

##### GMSH ######
ln -sf $HOME/dotFiles/gmsh/.gmshrc $HOME/
ln -sf $HOME/dotFiles/gmsh/.gmsh-options $HOME/

##### Lepton #####
ln -sf $HOME/dotFiles/lepton/.leptonrc $HOME/

##### Neofetch #####
mkdir -p $HOME/.config/neofetch
ln -sf $HOME/dotFiles/neofetch/config.conf $HOME/.config/neofetch/

##### Tmux #####
ln -sf $HOME/dotFiles/tmux/.tmux.conf $HOME/

##### Vim -- manual since contents are going multiple directories #####
mkdir -p $HOME/.vim
ln -sf $HOME/dotFiles/vim/.vimrc $HOME/ 
ln -sf $HOME/dotFiles/vim/myPlugins $HOME/.vim/myPlugins 

##### VS Code #####
mkdir -p $HOME/.config/Code/User
ln -sf $HOME/dotFiles/vscode/settings.json "$HOME/.config/Code/User/"
ln -sf $HOME/dotFiles/vscode/keybindings.json "$HOME/.config/Code/User/"
ln -sf $HOME/dotFiles/vscode/snippets "$HOME/.config/Code/User/snippets"
#sh $HOME/dotFiles/vscode/sharedConfig.sh
