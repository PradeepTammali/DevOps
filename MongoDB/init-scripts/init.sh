#!/bin/bash

# Check if I am the master mongo server, if not, delete myself and do not run
if [[ ${HOSTNAME} -ne "mongodb-0" ]]; then
    rm -rf /docker-entrypoint-initdb.d/init.sh
    exit 0
fi

# Check if file exists, if so, do not run this script, just delete it
if [[ -f /data/configdb/preconfigured ]]; then
    rm -rf /docker-entrypoint-initdb.d/init.sh
    exit 0
fi

# Configure replicaSet, create admin user and app user

mongo -- <<EOF
var cfg = { _id: "${MONGODB_REPLICASET}", version: 1, protocolVersion: 1, members: [{ _id: 0, host: "localhost:27017", arbiterOnly: false, buildIndexes: true, hidden: false, priority: 10 }]}
rs.initiate(cfg);
EOF

sleep 20

mongo -- <<EOF
use admin
db.createUser({user: "${MONGODB_CLUSTER_ADMIN_USER}",pwd: "${MONGODB_CLUSTER_ADMIN_PASSWORD}",roles: [{ role: "userAdminAnyDatabase", db: "admin"},{ role: "dbAdminAnyDatabase", db: "admin"},{ role: "readWriteAnyDatabase", db: "admin"},{ role: "root", db: "admin"}]});
EOF

sleep 5

mongo -u ${MONGODB_CLUSTER_ADMIN_USER} -p ${MONGODB_CLUSTER_ADMIN_PASSWORD} <<EOF
use admin
db.createUser({user: "app_admin", pwd: "${APP_ADMIN_PASSWORD}", roles: [{ role: "readWrite", db: "dbname1" },{ role: "dbAdmin", db: "dbname1" },{ role: "readWrite", db: "dbname2" },{ role: "dbAdmin", db: "dbname2" }]});

db.createUser({user: "app_analytics", pwd: "${APP_ANALYTICS_PASSWORD}", roles: [{ role: "read", db: "dbname1" },{ role: "read", db: "dbname2" }]});
EOF

# Create file in /data/configdb when this is complete to ensure this script is not re-run if container is deleted
if [[ $? -eq 0 ]]; then
    echo "Creating lock file..."
    touch /data/configdb/preconfigured
    echo "Done"
fi

# Delete myself
if [[ $? -eq 0 ]]; then
    echo "Deleting script..."
    rm -rf /docker-entrypoint-initdb.d/init.sh
    echo "Done"
fi
