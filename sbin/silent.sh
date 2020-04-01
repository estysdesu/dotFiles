#!/usr/bin/env sh

silent() {
  if [ "$DEBUG" != "1" ] ; then
    "$@"
  else
    "$@" &>/dev/null
  fi
}
