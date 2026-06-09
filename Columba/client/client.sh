#!/bin/bash
pkill -f ncat

echo -n "Entree l'adress du Serveur : "
read uss
pkg_value=3

ping -c $pkg_value $uss > a
ping_result1=$(awk -F " " '{print $1}' a | head -4 | tail -1)
rm a
echo $ping_result1

if [ $ping_result1 = "6" ]; then
    echo "Succes connection to the server !"
    echo ------------------------------------------
    echo -n "Entree l'adress du desttinataire : "
    read ip_destinataire
    echo -n "Message : "
    read msg

    touch msg_

    echo $ip_destinataire >> msg_
    echo " " >> msg_
    echo $msg >> msg_
    
    ncat $uss 50000 < msg_ 
    rm msg_

else
    echo "Desole serveur hors service"

fi

