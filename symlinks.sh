#!/usr/bin/env sh
##### ##### ##### ##### ##### ##### ##### #####
##### SYMLINK SETUP                       #####
##### ##### ##### ##### ##### ##### ##### #####

. ./env
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_CACHE_HOME"

sym_dir () {
    [ -d "$2" ] && rm -rf "$2"
    ln -sf "$1" "$2"
}

##### ALACRITTY #####
sym_dir "$DOTFILES/alacritty" "$XDG_CONFIG_HOME/alacritty"

##### BASH #####
ln -sf "$DOTFILES/bash/profile" "$HOME/.profile"

##### BIN (USER) #####
sym_dir "$DOTFILES/bin" "$HOME/bin"

##### ENV #####
ln -sf "$DOTFILES/env" "$HOME/.env"

##### HOMEBREW #####
#ln -sf "$DOTFILES/homebrew/Brewfile" "$HOME/"

##### GIT #####
sym_dir "$DOTFILES/git" "$XDG_CONFIG_HOME/git"

##### LEPTON #####
ln -sf "$HOME/dotFiles/lepton/.leptonrc" "$HOME/"

##### NEOFETCH #####
sym_dir "$DOTFILES/neofetch" "$XDG_CONFIG_HOME/neofetch"

##### NODE #####
ln -sf "$DOTFILES/node/.npmrc" "$HOME/"

##### PRUSA SLICER #####
mkdir -p "$HOME/Library/Application Support/PrusaSlicer"
for DIR in 'printer print filament'; do
		sym_dir "$DOTFILES/prusaSlicer/$DIR" "$HOME/Library/Application Support/PrusaSlicer/$DIR"
done

##### SKHD #####
sym_dir "$DOTFILES/skhd" "$XDG_CONFIG_HOME/skhd"

##### TMUX #####
sym_dir "$DOTFILES/tmux" "$XDG_CONFIG_HOME/tmux"

##### NEOVIM #####
sym_dir "$DOTFILES/nvim" "$XDG_CONFIG_HOME/nvim"

##### VS CODE INSIDERS #####
mkdir -p "$HOME/Library/Application Support/Code - Insiders/User"
for FILE in 'settings.json keybindings.json'; do
		ln -sf "$DOTFILES/vscode/$FILE" "$HOME/Library/Application Support/Code - Insiders/User/$FILE"
done
sym_dir "$DOTFILES/vscode/snippets" "$HOME/Library/Application Support/Code - Insiders/User/snippets"

##### YABAI #####
sym_dir "$DOTFILES/yabai" "$XDG_CONFIG_HOME/yabai"
