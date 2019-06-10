# first source .bashrc
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc

fi

# add MOTD
sh $HOME/bin/motd
