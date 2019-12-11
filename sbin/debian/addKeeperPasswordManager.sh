#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root." >&2
	exit 1
fi

wget -O /tmp/keeper.deb https://www.keepersecurity.com/desktop_electron/Linux/repo/deb/keeperpasswordmanager_14.9.12_amd64.deb
apt install /tmp/keeper.deb
apt update
apt upgrade keeperpasswordmanager
