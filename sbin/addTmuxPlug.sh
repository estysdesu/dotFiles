#!/usr/bin/env sh

set -e

if [ $(id -u) -eq 0 ]; then
	echo "This cannot be run as root." >&2
	exit 1
fi

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
