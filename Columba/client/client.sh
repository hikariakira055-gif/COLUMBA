#!/bin/bash
./clisten.sh & # ecoute permanent 
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
    


    #ncat 192.168.1.50 5555 < mon_fichier.txt 

else
    echo "Desoler serveur hors service"

fi


