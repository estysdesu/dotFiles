##### BASHRC #####
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

##### PATH #####
# Golang
export GOPATH="${HOME}/localProjects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# custom scripts
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

##### ALIASES #####
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits

##### PROMPT #####
export PROMPT_COMMAND="history -a; history -n" # share history between tabs by updating history on prompt load

# bash prompt becomes [“username@hostname:cwd $”]
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# bash prompt change to colorized
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # default
alias ls='ls -GFh'

##### FUNCTIONS ##### 
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

##### MISC #####
set -o vi # set vi editing mode
shopt -s checkwinsize # check & update window size after each command
export HOMEBREW_AUTO_UPDATE_SECS="604800" # homebrew only only update only once a week
export DOTFILES="$HOME/dotFiles"

# execute MOTD
sh $HOME/bin/motd
