#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi 

wget -q -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | apt-key add -
wget -O /tmp/teamviewer.deb https://download.teamviewer.com/download/linux/teamviewer_amd64.deb 
echo "deb http://linux.teamviewer.com/deb stable main" | tee /etc/apt/souces.list.d/teamviewer.list
apt install /tmp/teamviewer.deb
apt update
apt upgrade teamviewer
