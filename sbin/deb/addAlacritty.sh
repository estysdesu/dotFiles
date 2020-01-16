#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi

echo "deb http://ppa.launchpad.net/mmstick76/alacritty/ubuntu bionic main" | tee /etc/apt/sources.list.d/alacritty.list
# add-apt-repository -sy "deb http://ppa.launchpad.net/mmstick76/alacritty/ubuntu bionic main"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5B7FC40A404FAD98548806028AC9B4BBBAB4900B
apt update
apt install alacritty

tic -xe alacritty,alacritty-direct extra/alacritty.info
