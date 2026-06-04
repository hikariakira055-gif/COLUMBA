#!/bin/bash
pkill -f ncat
./clisten.sh >/dev/null 2>&1 & # ecoute permanent 
echo -n "Entree l'adress du Serveur : "
read uss
pkg_value=3

ping -c $pkg_value $uss > a
ping_result1=$(awk -F "" '{print $1}' a | head -4 | tail -1)
rm a


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
    
    ncat $uss 5555 < msg_ 

else
    echo "Desoler serveur hors service"

fi


rm msg_