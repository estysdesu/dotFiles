#!/usr/bin/env sh

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
