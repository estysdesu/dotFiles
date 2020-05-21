#!/usr/bin/env sh
# wget -qO - https://raw.githubusercontent.com/<user>/<repo>/<filepath> | sh

set -e # set -o errexit
set -u # set -o nounset
# set -x # set -o xtrace

PROGRAM_NAME='colorOutput'

colorOutput() {
  PRE="\033[${1}m"
  POST='\033[0m'
  if [ "$#" -gt 1 ]; then
    TEXT="$(echo "$@" | awk '{for (i=2; i<=NF; i++) printf "%s ", $i}')"
    printf "${PRE}%s${POST}" "$TEXT"
  else # stdin input
    printf "$PRE"
    cat
    printf "$POST"
  fi  
}

export red() {
   colorOutput 31 "$@"
}

export green() {
   colorOutput 32 "$@"
}

export yellow() {
   colorOutput 33 "$@"
}

export blue() {
   colorOutput 34 "$@"
}
