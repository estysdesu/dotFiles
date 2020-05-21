#!/usr/bin/env sh
# wget -qO - https://raw.githubusercontent.com/<user>/<repo>/<filepath> | sh [-s -- uninstall] 

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

PROGRAM_NAME='docker'
KEYRING_FILE="/etc/apt/trusted.gpg.d/${PROGRAM_NAME}.gpg"
SOURCE_FILE="/etc/apt/sources.list.d/${PROGRAM_NAME}.list"

echo 'NOTE: Docker is packaged in recent Debian and Ubuntu releases as docker.io and docker-compose. This install follows the recommended steps on Docker'\''s website.'

if [ "$(echo "$1" | awk '{print tolower($0)}')" = "install" ] || [ "$#" -eq 0 ]; then
	echo "Installing..."
	apt install -y apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL "https://download.docker.com/linux/$DISTRO/gpg" | apt-key --keyring "$KEYRING_FILE" add -
	echo "deb [arch=amd64] https://download.docker.com/linux/$DISTRO $CODENAME \
		stable" > "$SOURCE_FILE"
	apt update
	apt install -y docker-ce \
		docker-ce-cli \
		docker-compose \
		containerd.io
elif [ "$(echo "$1" | awk '{print tolower($0)}')" = "uninstall" ]; then
	echo "Uninstalling..."
	rm "$KEYRING_FILE"
	rm "$SOURCE_FILE"
	apt remove --purge -y docker-ce \
		docker-ce-cli \
		docker-compose \
		containerd.io
	apt autoremove -y
	apt update 
else
	echo "This script can only be used to install/uninstall" >&2
	exit 1
fi
