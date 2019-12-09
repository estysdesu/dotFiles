#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi 

wget -O "/tmp/nordvpn-release_1.0.0_all.deb" "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb"
apt install "/tmp/nordvpn-release_1.0.0_all.deb"
apt update
apt install nordvpn
