#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root" >&2
	exit 1
fi

echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu eoan main" | tee /etc/apt/sources.list.d/qbittorrent.list
apt update
apt install qbittorrent-nox

systemctl is-active --quiet qbittorrent
if [ $? -ne 0 ]; then
	systemctl start qbittorrent
	systemctl enable qbittorrent
fi
bash -c 'cat <<EOF > /etc/systemd/system/qbittorrent.service
[Unit]
Description=qBittorrent Daemon Service
Documentation=man:qbittorrent-nox(1)
Wants=network-online.target
After=network-online.target nss-lookup.target

[Service]
Type=exec
ExecStart=/usr/bin/qbittorrent-nox
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
EOF'

apt install ufw
ufw allow 8080 
