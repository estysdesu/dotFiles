#!/usr/bin/env bash

##### SETUP #####
set -e # error handling

raspURL='https://downloads.raspberrypi.org/raspbian_lite_latest'

raspTemp="$TMPDIR"raspbian
today=`date "+%Y_%m_%d"`
raspBaseName="$raspTemp"/"$today"_raspbian_lite_latest
raspZip="$raspBaseName".zip

abort () { 
	echo 'Program aborted.'
	if [ -z $1 ]; then
		status=1
	else
		status=0
	fi
	exit $status
}

##### DOWNLOAD & EXTRACT #####
if [ ! -f "$raspZip" ] && [ ! -f "$raspBaseName"/*.img ]; then
	echo 'Downloading latest Raspbian image...'
	mkdir -p "$raspBaseName"
	wget -O "$raspZip" "$raspURL" &> /dev/null
	echo "Extracting from archive...\n"
	unzip -d "$raspBaseName" "$raspZip" &> /dev/null
elif ( [ -f "$raspZip" ] && [ ! -f "$raspBaseName"/*.img ] ); then
	echo "Extracting from archive...\n"
	unzip -d "$raspBaseName" "$raspZip" &> /dev/null
else
	echo "Raspbian image located.\n"
fi
raspImg=`ls "$raspBaseName"/*.img`

##### DISK SELECTION #####
diskListResponse=`diskutil list external`
if [ "$diskListResponse" = "" ]; then 
	echo 'No external disks detected.'
	abort 1
else
	echo 'External disks: '
	echo "$diskListResponse\n"
fi

while read -p 'Enter the disk identifier (e.g. disk2): ' diskId; do
	diskutil info "$diskId" &> /dev/null
	if [ $? -eq 0 ]; then
		break
	else
		echo "\nInvalid disk identifier. Please try again."
		continue
	fi
done
diskPath="/dev/$diskId"

##### IMAGING #####
while read -p 'This disk will be overwritten. Do you wish to continue? [y]es/[n]o: ' confirm; do
	case "$confirm" in
		y|yes) break ;;
		n|no) abort 0 ;;
		*) echo "\nInvalid input. Please try again."; continue ;;
	esac
done

echo 'Please grant sudo permissions to image disk.'
sudo -v

echo "Imaging '$diskId'. Please wait, this could take a while..."
diskutil unmountDisk "$diskPath" &> /dev/null
sudo dd bs=1M if="$raspImg" of="$diskPath" conv=sync # check progress with SIGINFO (Ctrl+T)
echo "Imaging complete.\n"

##### SSH & WIFI #####
bootDir="/Volumes/boot"
while echo "Do you want to enable any additonal features?\n1) SSH\n2) WiFi\n3) No, I'm finished.\n"; read -p "Option: " options; do
	case "$options" in
		1) # SSH
			touch "$bootDir"/ssh; echo "\nSSH enabled." ;;
		2) # WiFi
			read -p 'Wifi name: ' wifiId
			read -sp 'Wifi password: ' wifiPass; echo
			cat > "$bootDir"/wpa_supplicant.conf <<EOL
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
	ssid="$wifiId"
	psk="$wifiPass"
}
EOL
			echo "\nWiFi enabled." ;;
		3)
			diskutil eject "$diskPath" &> /dev/null
			echo 'The disk is ejected. It is now safe to remove.'
			exit 0 ;;
		*) echo "\nInvalid input. Please try again."; continue ;;
	esac
done
