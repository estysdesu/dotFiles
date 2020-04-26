##### ZSHRC #####
setopt vi # set vi editing mode
setopt histappend
autoload -Uz bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit
autoload -Uz compinit && compinit
autoload -Uz colors && colors

##### ALIASES & GLOBALS #####
alias rezsh="source $HOME/.zshrc" # reload bash profile
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits; use trash-cli instead
alias grep='rg' # colorize grep match
alias ls='lsd -FAh' # https://github.com/Peltoche/lsd
alias cat='bat' # https://github.com/sharkdp/bat
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"
alias hdi='howdoi -n=3 -e=google -c' # $@ args # -e=duckduckgo

##### PROMPT #####
export PS1="%{$fg[yellow]%}[%~]${prompt_newline}%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$reset_color%}%# " # prompt becomes ([cwd]'\n'username@hostname % )

##### INITIALIZE #####
# nix
if [ -e /Users/estysdesu/.nix-profile/etc/profile.d/nix.sh ]; then
	source /Users/estysdesu/.nix-profile/etc/profile.d/nix.sh
fi

# pipx
eval "$(register-python-argcomplete pipx)"

# pyenv
eval "$(pyenv init -)"

# Execute MOTD
sh $HOME/bin/motd
