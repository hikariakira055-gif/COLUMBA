#!/bin/bash

touch inbox
while true; do

    ncat -l  5555 > "inbox/inbox_$(date +%H%M%S)"
    echo "Packet recu ! Redemmarage de ncat !"

done