#!/usr/bin/env bash

# TODO:
# 	* fix probing disk if present -- diskutil currently ejects you from the script


##### SETUP #####
set -e # error handling
trap abort SIGINT

abort () { 
	# A wrapper around exit that allows emitting a message on exit.
	# Inputs:
	# 	msg: str

	if [ ! -z "$1" ]; then
		echo "$1"
		exit 1
	else
		echo 'Program aborted.'
		exit 0
	fi
}

# check shell
if [ $(ps -p $$ -ocomm=) != 'bash' ]; then
	abort 'This program must be run with bash.'
fi

# check Mac
if [ $(uname -o) != 'Darwin' ]; then
	abort 'This program is only supported for on macOS.'
fi

# define Raspbian types
RASP_LITE_URL='https://downloads.raspberrypi.org/raspbian_lite_latest'
RASP_DESKTOP_URL='https://downloads.raspberrypi.org/raspbian_latest'
RASP_FULL_URL='https://downloads.raspberrypi.org/raspbian_full_latest'

# let user decide Raspbian type
while echo -e 'Which image would you like to download?\n\t1) Raspbian Lite\n\t2) Raspbian with Desktop\n\t3) Raspbian Desktop Full'; \
	read -p 'Option: ' imgType; do
	case "$imgType" in
		1|lite) 
			raspURL=$RASP_LITE_URL
		       	raspType='lite' 
			break ;;
		2|desktop) 
			raspURL=$RASP_DESKTOP_URL
			raspType='desktop' 
			break ;;
		3|full) 
			raspURL=$RASP_FULL_URL 
			raspType='full' 
			break ;;
		*) echo 'Invalid input. Please try again.'; sleep 1; continue ;;
	esac
done

# define paths
raspTempDir="${TMPDIR%/}/raspbian"
today=$(date "+%Y%m%d")
raspBaseName="${raspTempDir}/${today}_raspbian_${raspType}_latest"
raspZip="${raspBaseName}.zip"

##### DOWNLOAD & EXTRACT #####
# download
if [ ! -f "$raspZip" ]; then
	echo "Downloading latest Raspbian $raspType image..."
	wget -O "$raspZip" "$raspURL" &> /dev/null
else
	echo 'Latest Raspbian image previously downloaded.'
fi

# check hash and extract
if ( [ -f "$raspZip" ] && [ ! -f "${raspBaseName}/*.img" ] ); then
 	while echo -e "Please verify the SHA256 hash from https://www.raspberrypi.org/downloads/raspbian/: \n\t $(shasum -a 256 $raspZip | cut -d ' ' -f 1 )"; \
		read -p 'Do you wish to continue? [y]es/[n]o: ' hashAccept; do
 		case "$hashAccept" in
 			y|yes) break ;;
 			n|no) abort 'Program aborted at hash check.' ;;
 			*) echo 'Invalid input. Please try again.'; sleep 1; continue ;;
 		esac
	done

	echo 'Extracting from archive...'
	mkdir -p "$raspBaseName"
	unzip -f -d "$raspBaseName" "$raspZip" &> /dev/null
else
	echo 'Latest Raspbian image previously extracted.'
fi
raspImg=$(ls "$raspBaseName"/*.img)

##### DISK SELECTION #####
diskListResponse=$(diskutil list external)
if [ "$diskListResponse" = "" ]; then 
	abort 'No external disks detected.'
else
	echo 'External disks: '
	echo "$diskListResponse\n"
fi

while read -p 'Enter the disk identifier (e.g. disk2 or 4): ' diskId; do
	# allow inputs that contain only a digit
	if [[ "$diskId" =~ ^[0-9]+$ ]]; then
		diskId="disk${diskId}"
	fi

	break
#	diskutil info "$diskId" # &> /dev/null
#	if [ $? -eq 0 ]; then
#		break
#	else
#		echo 'Invalid disk identifier. Please try again.'; sleep 1; continue
#	fi
done
diskPath="/dev/$diskId"

##### IMAGING #####
while echo 'This disk will be overwritten.'; read -p 'Do you wish to continue? [y]es/[n]o: ' confirm; do
	case "$confirm" in
		y|yes) break ;;
		n|no) abort 0 ;;
		*) echo 'Invalid input. Please try again.'; sleep 1; continue ;;
	esac
done

echo 'Please grant sudo permissions to image disk.'
sudo -v

echo "Imaging $diskId. Please wait, this could take a while..."
diskutil unmountDisk "$diskPath" &> /dev/null
sudo dd bs=1M if="$raspImg" of="$diskPath" conv=sync &> /dev/null # check progress with SIGINFO (Ctrl+T)
echo "Imaging complete."

##### SSH & WIFI #####
bootDir="/Volumes/boot"
while echo "Do you want to enable any additonal features?\n1) SSH\n2) WiFi\n3) No, I'm finished.\n"; read -p "Option: " options; do
	case "$options" in
		1) # SSH
			touch "$bootDir"/ssh; echo "SSH enabled." ;;
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
			echo "WiFi enabled." ;;
		3)
			diskutil eject "$diskPath" &> /dev/null
			echo 'The disk is ejected. It is now safe to remove.'
			exit 0 ;;
		*) echo 'Invalid input. Please try again.'; sleep 1; continue ;;
	esac
done
