#!/usr/bin/env bash

stableDir="$HOME/Library/Application Support/Code/User"
insidersDir="$HOME/Library/Application Support/Code - Insiders/User"

# Link settings
ln -sfL "$stableDir/{settings.json,keybindings.json}" "$insidersDir/"
ln -sfFn "$stableDir/snippets" "$insidersDir/snippets"

