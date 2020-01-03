#!/usr/bin/env sh

set -e

if [ $(id -u) -eq 0 ]; then
	echo "This cannot be run as root." >&2
	exit 1
fi

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
