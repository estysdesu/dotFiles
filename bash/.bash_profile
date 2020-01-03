##### BASHRC #####
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

##### FUNCTIONS #####
# function for changing the PATH variable more efficiently
path_munge () {
	if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
		if [ "$2" = "after" ]; then
              		PATH="$PATH:$1"
      	  	elif [ "$2" = "before" ]; then
			PATH="$1:$PATH"
		else
              		PATH="$1:$PATH"
           	fi
		export PATH
        fi
}

##### PATH #####
# custom scripts
if [ -d "$HOME/bin" ] ; then
    path_munge "$HOME/bin" before
fi

##### ALIASES & GLOBALS #####
alias rebash="source $HOME/.bash_profile" # reload bash profile
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"
alias grep='grep --color' # colorize grep match
alias ls='lsd -FAh --icon=never' # https://github.com/Peltoche/lsd
alias cat='bat' # https://github.com/sharkdp/bat
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits

##### PROMPT #####
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # Bash prompt becomes (username@hostname:cwd$ )
export CLICOLOR=1 # bash prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

##### MISC #####
set -o vi # set vi editing mode
export DOTFILES="$HOME/dotFiles"
shopt -s histappend

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
	. /etc/bash.command-not-found
fi

# Execute MOTD
sh $HOME/bin/motd
