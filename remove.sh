#!/usr/bin/env sh
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist
launchctl remove org.lyon-smith.mongodb1
launchctl remove org.lyon-smith.mongodb2
launchctl remove org.lyon-smith.mongodb3
pkill -f /usr/local/opt/mongodb/bin/mongod
sleep 5

rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist

rm -f /usr/local/var/mongodb1/*.lock
rm -f /usr/local/var/mongodb2/*.lock
rm -f /usr/local/var/mongodb3/*.lock

