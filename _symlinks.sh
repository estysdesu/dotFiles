#!/usr/bin/env bash

##### set symlinks for dotFiles #####
# Alacritty
ln -sf $HOME/dotFiles/alacritty/.alacritty.yml $HOME/
# Bash
ln -sf $HOME/dotFiles/bash/{.bash_profile,.bashrc,.profile} $HOME/
# Bin [user]
<<<<<<< HEAD:symLinks.sh
ln -sfFn $HOME/dotFiles/bin $HOME/bin
# Homebrew
ln -sf $HOME/dotFiles/homebrew/Brewfile $HOME/
=======
ln -sfn $HOME/dotFiles/bin $HOME/bin
>>>>>>> 0947b7a... update dotfiles from make:_symlinks.sh
# Git
ln -sf $HOME/dotFiles/git/.gitignore_global $HOME/
# GMSH
ln -sf $HOME/dotFiles/gmsh/{.gmshrc,.gmsh-options} $HOME/
# iTerm2
# ln -sf $HOME/dotFiles/iterm/estysdesu.itermcolors #<path/to/iterm/conf>
# Lepton
ln -sf $HOME/dotFiles/lepton/.leptonrc $HOME/
# Neofetch
ln -sf $HOME/dotFiles/neofetch/config.conf $HOME/.config/neofetch/
# Prusa Slicer
ln -sfn $HOME/dotfiles/prusaSlicer/{printer,'print',filament} "$HOME/Library/Application Support/PrusaSlicer/"
# Tmux
ln -sf $HOME/dotFiles/tmux/.tmux.conf $HOME/
# Vim -- manual since contents are going multiple directories
ln -sf $HOME/dotFiles/vim/.vimrc $HOME/ 
ln -sfn $HOME/dotFiles/vim/myPlugins $HOME/.vim/myPlugins 
# VS Code
<<<<<<< HEAD:symLinks.sh
ln -sf $HOME/dotFiles/vscode/{settings.json,keybindings.json} "$HOME/Library/Application Support/Code/User/"
ln -sfFn $HOME/dotFiles/vscode/snippets "$HOME/Library/Application Support/Code/User/snippets"
=======
# ln -sf $HOME/dotFiles/vscode/{settings.json,keybindings.json} "$HOME/Library/Application Support/Code/User/"
# ln -sfn $HOME/dotFiles/vscode/snippets "$HOME/Library/Application Support/Code/User/snippets"
>>>>>>> 0947b7a... update dotfiles from make:_symlinks.sh
# sh $HOME/dotFiles/vscode/sharedConfig.sh
# Ranger
ln -sf $HOME/dotFiles/ranger/rc.conf $HOME/.config/ranger/
