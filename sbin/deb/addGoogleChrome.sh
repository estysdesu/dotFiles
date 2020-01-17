#!/usr/bin/env bash

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This needs to be run as root." >&2
	exit 1
fi

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt update
apt install google-chrome-stable 

