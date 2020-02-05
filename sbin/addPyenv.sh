#!/usr/bin/env sh

set -e

if [ $(id -u) -eq 0 ]; then
	echo "This script cannot be run as root" >&2
	exit 1
fi

curl -SsL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
