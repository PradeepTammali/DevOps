#!/bin/bash

# Check if file exists, if so, do not run the installation
if [[ ! -f /usr/local/bin/kubectl ]]; then
        apt update && apt install curl -y && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
fi

while :
do
        if [[ $(mongo --quiet --eval "printjson(db.isMaster().ismaster)") == "true" ]]; then
                # Label the pod with primary
                kubectl label --overwrite pod ${HOSTNAME} mongo.node=primary
        else
                # Label the pod with secondary
                kubectl label --overwrite pod ${HOSTNAME} mongo.node=secondary
        fi
        sleep 30
done
