#!/usr/bin/env bash

##### Google Chrome Install
# 	Requires/Installs: wget, google-chrome-stable 
##### 

set -e

# Ask for sudo permissions upfront
echo 'Please give sudo permissions'
sudo -v

# Install curl 
echo 'Installing wget...'
sudo apt install wget

echo 'Installing Google Chrome...'
# Add Google PGP Signature key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Add the Google repository
echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/googlechrome.list
# Update apt listings 
sudo apt update
# Install Google Chrome
sudo apt install google-chrome-stable 

