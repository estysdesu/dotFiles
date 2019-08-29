#!/usr/bin/env bash

stableDir="$HOME/Library/Application Support/Code/User"
insidersDir="$HOME/Library/Application Support/Code - Insiders/User"

# Link settings
ln -sf "$stableDir/settings.json" "$insidersDir/"
ln -sf "$stableDir/keybindings.json" "$insidersDir/"
ln -sfFn "$stableDir/snippets" "$insidersDir/snippets"

# Mirror extensions (but newer versions may be present)
for ext in `code --list-extensions`; do code-insiders --install-extension $ext; done
