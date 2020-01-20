#!/usr/bin/env sh

set -e

if [ $(id -u) -eq 0 ]; then
	echo "This script cannot be run as root" >&2
	exit 1
fi

newUser=`whoami`
echo "Installing sudo as root..."
su - -c "apt install sudo"
echo "Adding $newUser to sudoers group as root..."
su - -c "/usr/sbin/usermod -aG sudo $newUser"
exit 0
