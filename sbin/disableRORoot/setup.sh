#!/usr/bin/env sh
HERE=$HOME/dotFiles/sbin/disableRORoot

chmod +x "$HERE/disableRORoot.sh"
chmod 0644 "$HERE/com.disableRORoot.startup.plist"
chown root:wheel "$HERE/com.disableRORoot.startup.plist"

ln -sf "$HERE/com.disableRORoot.startup.plist" /Library/LaunchDaemons/