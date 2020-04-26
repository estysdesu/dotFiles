##### ZSHENV #####

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

# homebrew
path_munge "/usr/local/bin" before
brew_pre="`brew --prefix`"
brew_opt="$brew_pre/opt"

path_munge "$brew_pre/sbin" before # brew sbin
path_munge "$brew_opt/coreutils/libexec/gnubin" before # brew coreutils
path_munge "$brew_opt/llvm/bin" before # brew llvm
path_munge "$brew_opt/ruby/bin" before # brew Ruby
path_munge "$brew_opt/sqlite/bin" before # brew SQLite
path_munge "$HOME/.cargo/bin" after # Rust & Cargo
export GOPATH="${HOME}/go" # Go
export GOROOT="$brew_opt/go/libexec" # Go
path_munge "${GOROOT}/bin" after # Go
path_munge "${GOPATH}/bin" after # Go
path_munge "$HOME/.npm-global/bin" after # Node & NPM
path_munge "$HOME/.pyenv/bin" before  # pyenv
path_munge "$HOME/.local/bin" before  # pipx
path_munge "$HOME/bin" before

alias jupyterEnv='~/pythonEnvs/jupyter/bin/activate'
alias vim="nvim"
export EDITOR="nvim"
export OneDrive="${HOME}/OneDrive - University of Cincinnati"
export DOTFILES="$HOME/dotFiles"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_AUTO_UPDATE_SECS=604800 # homebrew only update once a week