#!/usr/bin/env sh
# wget -qO - https://raw.githubusercontent.com/<user>/<repo>/<filepath> | sh

set -e # set -o errexit
set -u # set -o nounset
# set -x # set -o xtrace

if [ "$(id -u)" -ne 0 ]; then
	echo "This script needs to be run as root" >&2
	exit 1
fi

DISTRO="$(lsb_release -is | awk '{print tolower($0)}')"
CODENAME="$(lsb_release -cs)"

if [ "$DISTRO" != "debian" ] && [ "$DISTRO" != "ubuntu" ]; then
	echo "This script is only implemented on debian based distros" >&2
	exit 1
fi

PROGRAM_NAME='bootstrap'

echo 'Installing server utilities...'
apt install -y sudo \
	neovim \
	tmux 
COCKPIT_URL="https://raw.githubusercontent.com/estysdesu/dotFiles/linux/sbin/deb/installCockpit.sh"
DOCKER_URL="https://raw.githubusercontent.com/estysdesu/dotFiles/linux/sbin/deb/installDocker.sh"
for URL in $COCKPIT_URL $DOCKER_URL; do
	wget -qO - $URL | eval
done

echo 'Setting up admin/sudo user...'
read -s 'Username: ' USERNAME
read -sp 'Password: ' PASSWORD
useradd -m -G sudo $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

echo 'Setup complete.'
echo "SSH Access: ssh $USERNAME@$(hostname -I | awk '{print $1}')"
