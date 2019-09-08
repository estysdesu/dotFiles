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

# custom scripts
if [ -d "$HOME/bin" ] ; then
    path_munge "$HOME/bin" before
fi

brew_opt="`brew --prefix`/opt"
path_munge "$brew_opt/coreutils/libexec/gnubin" before # brew coreutils
path_munge "$brew_opt/ruby/bin" before # brew Ruby
path_munge "$brew_opt/sqlite/bin" before # brew SQLite
# path_munge "brew_opt/cython/bin" after # brew Cython
path_munge "$HOME/.cargo/bin" after # Rust & Cargo
# brew Golang
export GOPATH="${HOME}/projects/golang"
export GOROOT="$brew_opt/go/libexec"
path_munge "${GOROOT}/bin" after
path_munge "${GOPATH}/bin" after

##### ALIASES #####
alias rebash="source $HOME/.bash_profile" # reload bash profile
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'" # hide rm functionality to decrease bad habits
# alias ls='ls -GFh'
alias grep='grep --color' # colorize grep match
alias ls='lsd -FAh' # https://github.com/Peltoche/lsd
alias cat='bat' # https://github.com/sharkdp/bat
alias spotifyWeb="'`locate "*Google\ Chrome"`' --app="https://play.spotify.com"" # Spotify web client without all the junk
alias ppPATH="echo $PATH | tr -s ':' '\n'"
alias cincyWttr="curl https://wttr.in/Cincinnati"

##### PROMPT #####
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # Bash prompt becomes (username@hostname:cwd$ )
export CLICOLOR=1 # bash prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

##### MISC #####
set -o vi # set vi editing mode
export HOMEBREW_AUTO_UPDATE_SECS=604800 # homebrew only update once a week
export DOTFILES="$HOME/dotFiles"
shopt -s histappend

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Execute MOTD
sh $HOME/bin/motd
