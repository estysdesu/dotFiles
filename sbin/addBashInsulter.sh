#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi

wget -O /etc/bash.command-not-found https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found
