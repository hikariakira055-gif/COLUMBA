#!/bin/bash

pkill -f ncat
CONF_FILE="../config/config.conf"
LISTEN_PORT=$(cat $CONF_FILE | awk '$1 == "FILE_CLIENT_PORT:" {print $2}')

fuser -9 -k 50002/tcp 50003/tcp

while true; do

    ncat -l -p $LISTEN_PORT | tar -xvf - 
    
    # Un micro-sleep pour laisser souffler le système
    sleep 0.1
done
killall -9 clisten.sh
