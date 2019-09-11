# Plex Media Server install and setup
# 	Requires/Installs: curl, apt-transport-https, plexmediaserver
#	If ufw is enabled, it opens firewall access for SSH and plexmediaserver (standard + dlna)


# Ask for sudo permissions upfront
echo 'Please give sudo permissions'
sudo -v

# Ensure curl is installed
command -v curl &> /dev/null
if [ $? -ne 0]; then
	echo 'Installing curl...'
	apt install curl &> /dev/null
fi

# Install apt-trasnport-https
apt install apt-transport-https &> /dev/null

# Add Plex PGP Signature key
echo 'Installing plex...'
curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - &> /dev/null
# Add the Plex repository
echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list &> /dev/null

# Update apt listings 
apt update &> /dev/null

# Install Plex Media Server
dpkg -l plexmediaserver &> /dev/null
if [ $? -ne 0]; then
	apt install plexmediaserver &> /dev/null
fi

# Check if plexmedia server is active
systemctl is-active --quiet plexmediaserver
if [ $? -ne 0]; then
	systemctl start plexmediaserver
fi

# Edit firewall (UFW) if enabled
ufw status | grep -qw active &> /dev/null
if [ $? -eq 0]; then
	ufw allow 22 # SSH port
	cat <<EOF > /etc/ufw/applications.d/plexmediaserver
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
EOF
	ufw app update plexmediaserver
	ufw allow plexmediaserver-all
fi

# Create the plex user's media directory and give it to them
plexMediaDir='/opt/plexmedia'
mkdir -p "$plexMediaDir/{movies,series}"
chown -R plex: "$plexMediaDir"
echo "Plex Media Server runs as user 'plex'"
echo "All Plex media should be located in $plexMediaDir, the environment variable 'plexMediaDir' and added to your '.bash_profile'; please source it after running this script"
echo "\nexport plexMediaDir=$plexMediaDir" >> "$HOME/.bash_profile"

# Give out server IP to access
echo 'Please access the server from one of the IP addresses listed below'
for ip in `hostname --all-ip-address`
do
	echo "http://$ip:32400/web"
done

exit 0
