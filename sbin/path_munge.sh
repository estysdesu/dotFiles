#!/usr/bin/env sh

# function for changing the PATH variable more efficiently
path_munge () {
	# check arguments are valid
	if [ -z "$2" ] && ([ "$2" != "before" ] || [ "$2" != "after" ]); then
		echo "error: invalid argument"
		exit 1
	fi
	if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
		if [ "$2" == "before" ]; then # "before" is not optional if user wants placed at beginning of path
              		PATH="$1:$PATH"
		else # handles $2="after" (optional)
              		PATH="$PATH:$1"
           	fi
		export PATH
        fi
}

