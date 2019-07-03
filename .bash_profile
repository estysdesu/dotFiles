##### BASHRC #####
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

##### FUNCTIONS ##### 
# reload bash profile
re_bash () {
	source $HOME/.bash_profile
}

# Node Version Manager
nvm_path () {
	export NVM_DIR="$HOME/.nvm";
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";
}

# Ruby Version Manager
rvm_path () {
	[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"; 
	export PATH="$PATH:$HOME/.rvm/bin"; 
}

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
# ignore path_helper if in tmux
if [ -n "$TMUX" ]; then
	if [ -f /etc/profile ]; then
    		PATH=""
    		source /etc/profile
	fi
fi

# Custom scripts
if [ -d "$HOME/bin" ] ; then
    path_munge "$HOME/bin" before
fi

# Brew SQLite
path_munge "/usr/local/opt/sqlite/bin" before

# Golang
export GOPATH="${HOME}/projects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
path_munge "${GOPATH}/bin" after
path_munge "${GOROOT}/bin" after

# Rust and Cargo
path_munge "$HOME/.cargo/bin" before

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

##### ALIASES #####
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits
# alias ls='ls -GFh'
alias ls=lsd # https://github.com/Peltoche/lsd
alias cat=bat # https://github.com/sharkdp/bat

##### PROMPT #####
export PROMPT_COMMAND="history -a; history -n" # share history between tabs by updating history on prompt load

# Bash prompt becomes [“username@hostname:cwd $”]
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# bash prompt change to colorized
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # default

##### MISC #####
set -o vi # set vi editing mode
shopt -s checkwinsize # check & update window size after each command
export HOMEBREW_AUTO_UPDATE_SECS="604800" # homebrew only only update only once a week
export DOTFILES="$HOME/dotFiles"

# Execute MOTD
sh $HOME/bin/motd

