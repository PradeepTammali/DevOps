#!/bin/bash

while true
do
    echo -e "#################################### Time: $(date '+%Y-%m-%d %H:%M:%S') ###################################################################" >> output.txt
    tcpdump port 53 2>&1 >> output.txt
    sleep 3600
done
