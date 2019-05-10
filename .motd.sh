#!/usr/local/bin/bash

# large ascii with figlet; fortune piped to cowsay
# figlet estysdesu
# fortune | cowsay -f moose 
printf "\nUser: %s\nHostname: %s\nDate : %s\nUptime : %s\n\n" "$(whoami)" "$(hostname -s)" "$(date)" "$(uptime)"

