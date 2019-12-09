#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi 

wget -O /tmp/teamviewer_amd64.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb 
apt install /tmp/teamviewer_amd64.deb
wget -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | apt-key add -
