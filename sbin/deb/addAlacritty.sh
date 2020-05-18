#!/usr/bin/env sh
# wget -qO - https://raw.githubusercontent.com/<user>/<repo>/<filepath>

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi

DISTRO="$(lsb_release -is | awk '{print tolower($0)}')"
CODENAME="$(lsb_release -cs)"

if [ "$DISTRO" != "debian" ] && [ "$DISTRO" != "ubuntu" ]; then
	echo "This script is only implemented on debian based distros" >&2
	exit 1
fi

echo "deb http://ppa.launchpad.net/mmstick76/alacritty/ubuntu focal \
	main" > /etc/apt/sources.list.d/alacritty.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
	--recv-keys 5B7FC40A404FAD98548806028AC9B4BBBAB4900B
apt update
apt install alacritty
