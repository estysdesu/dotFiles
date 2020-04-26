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

##### ALIASES & GLOBALS #####
alias rebash="source $HOME/.bash_profile" # reload bash profile
alias grep='grep --color' # colorize grep match
alias ls='ls -GFh'
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"
alias vim="nvim"
export EDITOR="nvim"
export DOTFILES="$HOME/dotFiles"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

##### PROMPT #####
export CLICOLOR=1 # prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default
export PS1="\[$(tput setaf 3)\][\w]\[$(tput sgr0)\]\n\[$(tput setaf 4)\]\u\[$(tput sgr0)\]@\[$(tput setaf 2)\]\h\[$(tput sgr0)\] \$ \[$(tput sgr0)\]"


