##### ZSHRC #####
setopt vi # set vi editing mode
setopt histappend
autoload -Uz bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit
autoload -Uz compinit && compinit
autoload -Uz colors && colors

source "$HOME/dotFiles/env"

##### ALIASES & GLOBALS #####
# alias rezsh="source $HOME/.zshenv && source $HOME/.zshrc" # reload zsh profile
alias rm='echo Use `trash` unless `rm` is needed. If so, use the full path `/bin/rm` or `\rm`' # hide rm functionality to decrease bad habits; use trash-cli instead
alias grep='rg' # https://github.com/BurntSushi/ripgrep
alias ls='lsd -FAh' # https://github.com/Peltoche/lsd
alias cat='bat' # https://github.com/sharkdp/bat
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"
alias hdi='howdoi -n=3 -e=google -c' # $@ args # -e=duckduckgo
alias code='code-insiders'

##### PROMPT #####
function update_prompt() {
	PS1="%{$fg[yellow]%}[%~]${prompt_newline}%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$reset_color%}%# " # prompt becomes ([cwd]'\n'username@hostname % )
	if [ -n "$VIRTUAL_ENV" ]; then
		PS1="($(basename $VIRTUAL_ENV)) $PROMPT"
	fi
}
precmd() { update_prompt }

# Execute MOTD
sh $HOME/bin/motd.sh
