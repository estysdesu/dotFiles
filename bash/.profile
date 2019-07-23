
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

