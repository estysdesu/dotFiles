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

PROGRAM_NAME='cockpit'
# KEYRING_FILE="/etc/apt/trusted.gpg.d/${PROGRAM_NAME}.gpg"
# SOURCE_FILE="/etc/apt/sources.list.d/${PROGRAM_NAME}.list"

if [ "$(echo "$1" | awk '{print tolower($0)}')" = "install" ] || [ "$#" -eq 0 ]; then
	echo "Installing..."
	apt install -y cockpit \
		cockpit-dashboard \
		cockpit-packagekit \
		cockpit-networkmanager \
		cockpit-storaged \
		cockpit-machines \
		cockpit-docker
elif [ "$(echo "$1" | awk '{print tolower($0)}')" = "uninstall" ]; then
	echo "Uninstalling..."
	apt remove --purge -y cockpit \
		cockpit-dashboard \
		cockpit-packagekit \
		cockpit-networkmanager \
		cockpit-storaged \
		cockpit-machines \
		cockpit-docker \
		&& apt autoremove -y # apt packages
	apt update 
else
	echo "This script can only be used to install/uninstall" >&2
	exit 1
fi
