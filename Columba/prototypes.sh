#!/bin/bash

sudo tcpdump -i any icmp > chat.log &

set dst_ip
echo -n "DST IP : "
read dst_ip

set msg 


ip_user=$(ip a >> o && grep "inet " o >> p && awk '{print $2}' p |tail -1 >> a && awk -F '/' '{print $1}' a)
rm a o p



while true; do

    echo -n "> "
    read msg

    hash=$(echo -n $msg | -xxd -p)

    ping -c 1 -p $hash $dst_ip

done
