#!/usr/bin/env bash

##### Google Chrome Install
# 	Requires/Installs: wget, google-chrome-stable 
##### 

# Ask for sudo permissions upfront
echo 'Please give sudo permissions'
sudo -v

# Ensure curl is installed
command -v wget &> /dev/null
if [ $? -ne 0]; then
	echo 'Installing wget...'
	apt install wget &> /dev/null
fi

echo 'Installing Google Chrome...'
# Add Google PGP Signature key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Add the Google repository
echo deb http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/googlechrome.list &> /dev/null
# Update apt listings 
apt update &> /dev/null
# Install Google Chrome
dpkg -l google-chrome-stable &> /dev/null
if [ $? -ne 0]; then
	apt install google-chrome-stable &> /dev/null
fi

