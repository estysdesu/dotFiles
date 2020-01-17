#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This needs to be run as root." >&2
	exit 1
fi

wget -O /tmp/vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list
apt install /tmp/vscode.deb
apt update
apt upgrade code
