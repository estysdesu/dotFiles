##### BASHRC #####
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

##### FUNCTIONS #####


##### PATH #####
# ignore path_helper if in tmux
if [ -n "$TMUX" ]; then
	if [ -f /etc/profile ]; then
    		PATH=""
    		source /etc/profile
	fi
fi

# custom scripts
if [ -d "$HOME/bin" ] ; then
    path_munge "$HOME/bin" before
fi

##### ALIASES & GLOBALS #####


# Execute MOTD
sh $DOTFILES/bin/motd

