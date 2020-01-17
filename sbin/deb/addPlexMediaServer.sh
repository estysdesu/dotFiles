#!/usr/bin/env bash

##### Plex Media Server Install and Setup
#	Requires:		curl, apt-transport-https, ufw
# 	Installs:		plexmediaserver
#	Notes:			If ufw is enabled, it opens firewall access for SSH and plexmediaserver (standard + dlna)
##### 

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This needs to be run as root."
	exit 1
fi

apt install apt-transport-https curl
sh ./addUFW.sh

wget -q -O https://downloads.plex.tv/plex-keys/PlexSign.key - | apt-key add -
echo "deb https://downloads.plex.tv/repo/deb public main" | tee /etc/apt/sources.list.d/plexmediaserver.list 
apt update 
apt install plexmediaserver 

# Check if plexmedia server is active
systemctl is-active --quiet plexmediaserver
if [ $? -ne 0 ]; then
	systemctl start plexmediaserver
	systemctl enable plexmediaserver
fi

# Edit firewall (UFW) if enabled
ufw status | grep -qw active 
if [ $? -eq 0 ]; then
	sudo ufw allow 22 # SSH port
	sudo bash -c 'cat <<EOF > /etc/ufw/applications.d/plexmediaserver
	[plexmediaserver]
	title=Plex Media Server (Standard)
	description=The Plex Media Server
	ports=32400/tcp|3005/tcp|5353/udp|8324/tcp|32410:32414/udp

	[plexmediaserver-dlna]
	title=Plex Media Server (DLNA)
	description=The Plex Media Server (additional DLNA capability only)
	ports=1900/udp|32469/tcp

	[plexmediaserver-all]
	title=Plex Media Server (Standard + DLNA)
	description=The Plex Media Server (with additional DLNA capability)
	ports=32400/tcp|3005/tcp|5353/udp|8324/tcp|32410:32414/udp|1900/udp|32469/tcp
EOF'
	ufw app update plexmediaserver
	ufw allow plexmediaserver-all
fi

# Create the plex user's media directory and give it to them
plexMediaDir='/opt/plexmedia'
mkdir -p "$plexMediaDir/{movies,series}"
chown -R plex: "$plexMediaDir"
echo "Plex Media Server runs as user 'plex'"
echo "All Plex media should be located in $plexMediaDir, the environment variable 'plexMediaDir' is added to your '.bash_profile'; please source it after running this script"
echo "\nexport plexMediaDir=$plexMediaDir" >> "$HOME/.bash_profile"

# Give out server IP to access
echo 'Please access the server from one of the IP addresses listed below'
for ip in `hostname --all-ip-address`
do
	echo "http://$ip:32400/web"
done

exit 0
