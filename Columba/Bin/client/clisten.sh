#!/bin/bash

pkill -f ncat
REPERTOIRE_DU_SCRIPT="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
CONF_FILE="$REPERTOIRE_DU_SCRIPT/config/config.conf"

fuser -9 -k 50000/tcp 50001/tcp

while true; do
    # On écoute sur le port 5555. ncat attend qu'un message arrive.
    # Dès que quelqu'un se connecte, 'read' intercepte la première ligne
    # et c'est ce qui déclenche la création du fichier .in au bon moment.
    ncat -l -p $LISTEN_PORT | {
        if read -r first_line; then
            # On génère le nom du fichier avec la date
            filename="$REPERTOIRE_DU_SCRIPT/inbox/inbox_$(date +%H%M%S).in"
            
            # On écrit la première ligne interceptée, puis tout le reste du message
            echo "$first_line" > "$filename"
            cat >> "$filename"
            
            echo "Packet recu ! Redemmarage de ncat !"
            
        fi
    }
    
    # Un micro-sleep pour laisser souffler le système
    sleep 0.1
done
killall -9 clisten.sh