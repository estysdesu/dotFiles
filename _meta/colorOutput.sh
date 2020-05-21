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

red() {
   colorOutput 31 "$@"
}

green() {
   colorOutput 32 "$@"
}

yellow() {
   colorOutput 33 "$@"
}

blue() {
   colorOutput 34 "$@"
}

progressMark() {
  printf '%s' "$(blue '→')"
}

checkMark() {
  printf '%s' "$(green '✓')"
}

failMark() {
  printf '%s' "$(red '✗')"
}
