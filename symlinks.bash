#!/usr/bin/env bash

XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"

##### Alacritty #####
mkdir -p "$XDG_CONFIG_HOME/alacritty"
ln -sf "$HOME/dotFiles/alacritty/alacritty.yml" "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
##### Bash #####
ln -sf "$HOME/dotFiles/bash/{.bash_profile,.bashrc}" "$HOME/"
##### Bin [user] #####
ln -sfn "$HOME/dotFiles/bin" "$HOME/bin"
##### Homebrew #####
ln -sf "$HOME/dotFiles/homebrew/Brewfile" "$HOME/"
##### Git #####
mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$HOME"/dotFiles/git/{config,ignore} "$XDG_CONFIG_HOME/git/"
##### Lepton #####
ln -sf "$HOME/dotFiles/lepton/.leptonrc" "$HOME/"
##### Neofetch #####
mkdir -p "$XDG_CONFIG_HOME/neofetch"
ln -sf "$HOME/dotFiles/neofetch/config.conf" "$HOME/.config/neofetch/"
##### Node #####
ln -sf "$HOME/dotFiles/node/.npmrc" "$HOME/"
##### Prusa Slicer #####
ln -sfn "$HOME"/dotfiles/prusaSlicer/{printer,'print',filament} "$HOME/Library/Application Support/PrusaSlicer/"
##### Tmux #####
ln -sf "$HOME/dotFiles/tmux/.tmux.conf" "$HOME/"
##### NEOVIM #####
ln -sfn "$HOME/dotFiles/nvim" "$HOME/.config/nvim"
##### VS Code Insiders #####
ln -sf "$HOME"/dotFiles/vscode/{settings.json,keybindings.json} "$HOME/Library/Application Support/Code - Insiders/User/"
ln -sfn "$HOME/dotFiles/vscode/snippets" "$HOME/Library/Application Support/Code/User - Insiders/snippets"