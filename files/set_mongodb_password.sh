#!/bin/bash
set -m
cmd="/usr/bin/mongod --quiet -f /etc/mongodb.conf run"
$cmd  &
sleep 5
/usr/bin/mongo localhost/trading --eval 'db.addUser("trading_mongo", "trading")'
/usr/bin/mongo localhost/admin --eval 'db.addUser("admin", "admin")'
