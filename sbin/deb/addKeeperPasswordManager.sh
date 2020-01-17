#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root." >&2
	exit 1
fi

wget -O /tmp/keeper.deb https://www.keepersecurity.com/desktop_electron/Linux/repo/deb/keeperpasswordmanager_14.10.0_amd64.deb
echo "deb [arch=amd64] https://keepersecurity.com/desktop_electron/Linux/repo/deb stable main" | tee /etc/apt/sources.list.d/keeper.list
apt install /tmp/keeper.deb
apt update
apt upgrade keeperpasswordmanager
