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

# Brew coreutils (--with-default-names is depped)
path_munge "`brew --prefix coreutils`/libexec/gnubin" before

# Ruby
path_munge "`brew --prefix ruby`/bin" before

# Cython
path_munge "`brew --prefix cython`/bin" after

# Rust and Cargo
path_munge "$HOME/.cargo/bin" after

# Brew SQLite
path_munge "`brew --prefix sqlite`/bin" before

# Golang
export GOPATH="${HOME}/projects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
path_munge "${GOROOT}/bin" after
path_munge "${GOPATH}/bin" after

##### ALIASES #####
alias rebash="source $HOME/.bash_profile" # reload bash profile
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits
# alias ls='ls -GFh'
alias ls='lsd -FAh' # https://github.com/Peltoche/lsd
alias cat=bat # https://github.com/sharkdp/bat
alias spotify_web="'`locate "*Google\ Chrome"`' --app="https://play.spotify.com"" # Spotify web client without all the junk
alias ppPATH="echo $PATH | tr -s ':' '\n'"

##### PROMPT #####
export PROMPT_COMMAND="history -a; history -n" # share history between tabs by updating history on prompt load
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # Bash prompt becomes [“username@hostname:cwd $”]
export CLICOLOR=1 # bash prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default

##### MISC #####
set -o vi # set vi editing mode
shopt -s checkwinsize # check & update window size after each command
shopt -s extglob # extended pattern matching features
export HOMEBREW_AUTO_UPDATE_SECS="604800" # homebrew only only update only once a week
export DOTFILES="$HOME/dotFiles"

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Execute MOTD
sh $HOME/bin/motd
