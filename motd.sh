#!/usr/bin/sh

printf "\nUser: %s\nHostname: %s\nDate : %s\n\n" "$(whoami)" "$(hostname -s)" "$(date)"

printf "\n"; neofetch
