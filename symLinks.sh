#!/usr/local/bin/bash
# set symlinks for dotFiles
ln -sf $HOME/dotFiles/.bash_profile $HOME/.bash_profile
ln -sf $HOME/dotFiles/.bashrc $HOME/.bashrc
ln -sf $HOME/dotFiles/.gitignore $HOME/.gitignore
ln -sf $HOME/dotFiles/.vimrc $HOME/.vimrc
ln -sf $HOME/dotFiles/.brewfile $HOME/.brewfile
ln -sf $HOME/dotFiles/motd.sh /etc/motd.sh
ln -sf $HOME/dotFiles/.neofetch.conf $HOME/.config/neofetch/config.conf
ln -sf $HOME/dotFiles/.tmux.conf $HOME/.tmux.conf
