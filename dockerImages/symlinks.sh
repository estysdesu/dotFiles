#!/usr/bin/env bash

plexDir="$HOME/plexData"
openVPNDir="$HOME/openVPNData"

ln -sf plex.docker-compose.yaml "$plexDir"/
ln -sf openvpn-as.docker-compose.yaml "$openVPNDir"/
