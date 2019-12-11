#!/usr/bin/env sh

set -e

if [ $(id -u) -ne 0 ]; then
	echo "This needs to run as root." >&2
	exit 1
fi

curl -sS https://download.spotify.com/debian/pubkey.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update
apt install spotify-client
