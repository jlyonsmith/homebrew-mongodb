#!/usr/bin/env sh
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
launchctl unload ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist
launchctl remove org.lyon-smith.mongodb1
launchctl remove org.lyon-smith.mongodb2
launchctl remove org.lyon-smith.mongodb3
pkill -f /usr/local/opt/mongodb-community/bin/mongod
sleep 5

rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
rm -f ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist

cp -f *.plist /usr/local/opt/mongodb-community/
cp -f *.conf /usr/local/etc/
cp -f replicaset /usr/local/bin/

mkdir -p /usr/local/var/log/mongodb1
mkdir -p /usr/local/var/log/mongodb2
mkdir -p /usr/local/var/log/mongodb3
mkdir -p /usr/local/var/mongodb1
mkdir -p /usr/local/var/mongodb2
mkdir -p /usr/local/var/mongodb3

ln -sfv /usr/local/opt/mongodb-community/org.lyon-smith.mongodb1.plist ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
ln -sfv /usr/local/opt/mongodb-community/org.lyon-smith.mongodb2.plist ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
ln -sfv /usr/local/opt/mongodb-community/org.lyon-smith.mongodb3.plist ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist

rm -f /usr/local/var/mongodb1/*.lock
rm -f /usr/local/var/mongodb2/*.lock
rm -f /usr/local/var/mongodb3/*.lock

launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb1.plist
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb2.plist
launchctl load ~/Library/LaunchAgents/org.lyon-smith.mongodb3.plist

echo "Waiting for replica set..."
sleep 10

mongo --host 127.0.0.1:27018 <<EOF

var cfg = {
    "_id": "rs",
    "version": 1,
    "members": [
        {
            "_id": 0,
            "host": "127.0.0.1:27018",
            "priority": 1
        },
        {
            "_id": 1,
            "host": "127.0.0.1:27019",
            "priority": 1
        },
        {
            "_id": 2,
            "host": "127.0.0.1:27020",
            "priority": 1
        }
    ]
};

rs.initiate(cfg);
rs.reconfig(cfg)

EOF
