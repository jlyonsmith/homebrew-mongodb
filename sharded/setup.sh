#!/usr/bin/env sh -x

# first unload/stop mongod instances
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongos.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb_shardconfig.plist

# stop the original if it's running
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb.plist

pkill -f mongod

# Remove any current mongod launchagents
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongo*.plist

# Install these mongod launchagents
cp -f *.plist /usr/local/opt/mongodb/
cp -f *.conf /usr/local/etc/
cp -f shardset /usr/local/bin/

# Make sure the log and data directories exist
mkdir -p /usr/local/var/log/mongodb
mkdir -p /usr/local/var/mongodb_1
mkdir -p /usr/local/var/mongodb_2
mkdir -p /usr/local/var/mongodb_shardconfig/

# Put the launchagents in place
ln -sfv /usr/local/opt/mongodb/org.lyon-smith.mongo*.plist ~/Library/LaunchAgents/

# Make sure the original plist isn't there, since this overrides it =]
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb.plist

# Kill any lock files that haven't been cleaned up
rm -f /usr/local/var/mongodb_1/*.lock
rm -f /usr/local/var/mongodb_2/*.lock
rm -f /usr/local/var/mongodb_shardconfig/*.lock

# load/start mongod and mongos instances
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb_shardconfig.plist
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongos.plist

echo "Waiting for servers to be started..."
sleep 10

mongo --host 127.0.0.1 <<EOF

sh.addShard("127.0.0.1:27027");
sh.addShard("127.0.0.1:27028");

EOF
