#!/usr/bin/env sh
newUser=`whoami`
echo "Installing sudo as root..."
su - -c "apt install sudo"
echo "Adding $newUser to sudoers group as root..."
su - -c "/usr/sbin/usermod -aG sudo $newUser"
exit 0
