#!/usr/bin/env sh
# wget -qO - https://raw.githubusercontent.com/<user>/<repo>/<filepath>

set -e

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

if [ "$(echo "$1" | awk '{print tolower($0)}')" == "install" ]; then
	apt install -y apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL "https://download.docker.com/linux/$DISTRO/gpg" | apt-key add -
	echo "deb [arch=amd64] https://download.docker.com/linux/$DISTRO $CODENAME \
		stable" > /etc/apt/sources.list.d/docker.list
	apt update
	apt install -y docker-ce \
		docker-ce-cli \
		docker-compose \
		containerd.io
elif [ "$(echo "$1" | awk '{print tolower($0)}')" == "uninstall" ]; then
	echo "unimplemented..."
	exit 1
else
	echo "This script can only be used to install/uninstall" >&2
	exit 1
fi
