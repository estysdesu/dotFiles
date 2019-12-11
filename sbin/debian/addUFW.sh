#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This script needs to be run as root." >&2
	exit 1
fi

apt install ufw
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw status verbose
ufw allow ssh
