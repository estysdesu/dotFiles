#!/usr/bin/env bash

imagesDir="$HOME/dotFiles/dockerImages"
plexDir="$HOME/plexData"
openVPNDir="$HOME/openVPNData"
dockerFile="docker-compose.yaml"
ovpnDir="$HOME/ovpnData"

ln -sf "$imagesDir/plex.$dockerFile" "$plexDir/$dockerFile"
ln -sf "$imagesDir/openvpn-as.$dockerFile" "$openVPNDir/$dockerFile"
ln -sf "$imagesDir/ovpn.$dockerFile" "$ovpnDir/$dockerFile"
