#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi

apt install python3-pip
python3 -m pip install --upgrade keepercommander
