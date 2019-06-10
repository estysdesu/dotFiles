# set vi editing mode
set -o vi

# hide rm functionality to decrease bad habits
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'"

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Node Version Manager
nvm_path () {
	export NVM_DIR="$HOME/.nvm";
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";
}

 # Ruby Version Manager
 rvm_path () {
	 [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"; 
	 export PATH="$PATH:$HOME/.rvm/bin"; 
 }

# Golang
export GOPATH="${HOME}/localProjects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# history
export HISTCONTROL=ignoredups:erasedups # no duplicates
shopt -s histappend # append history instead of overwrite file
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # append after every command
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # append, clear local, and reload from file after every command; keeps in sync

# homebrew
export HOMEBREW_AUTO_UPDATE_SECS=604800 # update only once a week

# tmux
tmux attach &> /dev/null # attach if there is already a session
if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

# add scripts to the path if present
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# bash prompt becomes [“username@hostname:cwd $”]
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# bash prompt change to colorized
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # default
alias ls='ls -GFh'

