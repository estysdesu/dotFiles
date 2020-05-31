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

##### SETUP #####
PROGRAM_NAME='bootstrap'

colorOutput() {
  PRE="\033[${1}m"
  POST='\033[0m'
  if [ "$#" -gt 1 ]; then
    TEXT="$(echo "$@" | awk '{for (i=2; i<=NF; i++) printf "%s ", $i}')"
    printf "${PRE}%s${POST}" "$TEXT"
  else # stdin input
    printf "$PRE"
    cat
    printf "$POST"
  fi  
}

red() {
   colorOutput 31 "$@"
}

green() {
   colorOutput 32 "$@"
}

yellow() {
   colorOutput 33 "$@"
}

blue() {
   colorOutput 34 "$@"
}

progressMark() {
  printf '%s' "$(blue '→')"
}

checkMark() {
  printf '%s' "$(green '✓')"
}

failMark() {
  printf '%s' "$(red '✗')"
}

printf "%s " progressMark 'Beginnning bootstrap...'; 
# echo "$(progressMark 'Beginning bootstrap...')"
# wget -qO - "https://raw.githubusercontent.com/estysdesu/dotFiles/linux/_meta/colorOutput.sh" | . /dev/stdin


# systemd-network static ip setup https://www.linode.com/docs/networking/linux-static-ip-configuration/
##### UTILITIES #####
echo "$(progressMark 'Installing server utilities...')"
apt install -y sudo \
	ufw \
	neovim \
	tmux 
COCKPIT_URL="https://raw.githubusercontent.com/estysdesu/dotFiles/linux/sbin/deb/installCockpit.sh"
DOCKER_URL="https://raw.githubusercontent.com/estysdesu/dotFiles/linux/sbin/deb/installDocker.sh"
for URL in $COCKPIT_URL $DOCKER_URL; do
	wget -qO - $URL | sh
done
ufw enable && \
	ufw allow 22 && \
	ufw allow 9090/tcp && \
	ufw reload
echo "$(checkMark 'Done')"

##### USER #####
echo "$(progressMark 'Setting up admin/sudo user...')"
echo 'Full name: '; read -r FULL_NAME
echo 'Username: '; read -r USERNAME
echo 'Password: '; read -r PASSWORD
useradd -m -G sudo,docker -c "$FULL_NAME" "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd
echo "$(checkMark 'Done')"

##### MOUNT VOLUME #####
# echo "$(progressMark 'Mounting drives...')"
# echo 'Drive location: '; read -r DEVICE_PATH
# echo 'Mount location: '; read -r MOUNT_PATH
# echo 'Format?: [0=no/1=yes]'; read -r FORMAT
# if [ "$FORMAT" -eq 1 ]; then
# 	mkfs.ext4 "$DEVICE_PATH"	
# fi
# mkdir -p "$MOUNT_PATH"
# mount "$DEVICE_PATH" "$MOUNT_PATH"
# echo "$DEVICE_PATH $MOUNT_PATH ext4 defaults,noatime,nofail 0 2" > /etc/fstab
# echo "$(checkMark 'Done')"

echo "$(checkMark 'Setup complete')"
echo "SSH Access: ssh $USERNAME@$(hostname -I | awk '{print $1}')"
