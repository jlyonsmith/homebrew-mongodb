#!/usr/bin/env sh
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb1.plist
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb2.plist
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb3.plist
launchctl remove homebrew.mxcl.mongodb1
launchctl remove homebrew.mxcl.mongodb2
launchctl remove homebrew.mxcl.mongodb3
pkill -f /usr/local/opt/mongodb/bin/mongod
sleep 5

rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb1.plist
rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb2.plist
rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb3.plist

rm -f /usr/local/var/mongodb1/*.lock
rm -f /usr/local/var/mongodb2/*.lock
rm -f /usr/local/var/mongodb3/*.lock
