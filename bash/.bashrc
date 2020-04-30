source "$HOME/dotFiles/env"

##### ALIASES & GLOBALS #####
alias rebash="source $HOME/.bash_profile" # reload bash profile
alias grep='grep --color' # colorize grep match
alias ls='ls -GFh'
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"

##### PROMPT #####
export CLICOLOR=1 # prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default
function update_prompt() {
	export PS1="\[$(tput setaf 3)\][\w]\[$(tput sgr0)\]\n\[$(tput setaf 4)\]\u\[$(tput sgr0)\]@\[$(tput setaf 2)\]\h\[$(tput sgr0)\] \$ \[$(tput sgr0)\]"
	if [ -n "$VIRTUAL_ENV" ]; then
		PS1="($(basename $VIRTUAL_ENV)) $PS1"
	fi
}
export -f update_prompt
export PROMPT_COMMAND='update_prompt'

