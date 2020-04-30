##### BASHRC #####
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

# Execute MOTD
sh $DOTFILES/bin/motd.sh
