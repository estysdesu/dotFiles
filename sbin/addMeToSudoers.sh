newUser=`whoami`
echo "Switching to root user"
su
echo "Installing sudo..."
apt install sudo
echo "Adding $newUser to sudoers group..."
/usr/sbin/usermod -aG sudo $newUser
exit 0
