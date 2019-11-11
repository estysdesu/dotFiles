bootDir="/Volumes/boot"
while echo "Do you want to enable any additonal features?\n1) SSH\n2) WiFi\n3) No, I'm finished"; read -p "Option: " options; do
	case "$options" in
		1) # SSH
			touch "$bootDir"/ssh ;;
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
			echo 'WiFi enabled.' ;;
		3)
			diskutil eject "$diskPath" &> /dev/null
			echo 'The disk is ejected. It is now safe to remove.'
			exit 0 ;;
		*) echo 'Invalid input. Please try again.'; continue ;;
	esac
done
