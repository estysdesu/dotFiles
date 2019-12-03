#!/usr/bin/env bash

##### Plex Media Server Install and Setup
# 	Requires/Installs: curl, apt-transport-https, plexmediaserver
#	If ufw is enabled, it opens firewall access for SSH and plexmediaserver (standard + dlna)
##### 

set -e

# Ask for sudo permissions upfront
echo 'Please give sudo permissions'
sudo -v

# Install curl
sudo apt install curl
# Install apt-trasnport-https
sudo apt install apt-transport-https

echo 'Installing Plex...'
# Add Plex PGP Signature key
curl "https://downloads.plex.tv/plex-keys/PlexSign.key" | sudo apt-key add - 
# Add the Plex repository
echo "deb https://downloads.plex.tv/repo/deb public main" | sudo tee /etc/apt/sources.list.d/plexmediaserver.list 

# Update apt listings 
sudo apt update 

# Install Plex Media Server
sudo apt install plexmediaserver 

# Check if plexmedia server is active
sudo systemctl is-active --quiet plexmediaserver
if [ $? -ne 0 ]; then
	sudo systemctl start plexmediaserver
fi

# Edit firewall (UFW) if enabled
sudo ufw status | grep -qw active 
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
	sudo ufw app update plexmediaserver
	sudo ufw allow plexmediaserver-all
fi

# Create the plex user's media directory and give it to them
plexMediaDir='/opt/plexmedia'
sudo mkdir -p "$plexMediaDir/{movies,series}"
sudo chown -R plex: "$plexMediaDir"
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
