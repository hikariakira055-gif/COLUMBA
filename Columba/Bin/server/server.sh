#!/bin/bash
REPERTOIRE_DU_SCRIPT="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
while true; do
    #architecture
    arch=$(uname -a | awk '{print $1 " " $4 " " $13}')

    #Physical proc
    cpup=$(grep "physical id" /proc/cpuinfo | wc -l)

    #proc virtual
    cpuv=$(grep "processor" /proc/cpuinfo | wc -l)

    #ram
    ram_total=$(free --mega | awk '$1 == "Mem:" {print $2}')
    ram_used=$(free --mega | awk '$1 == "Mem:" {print $3}')
    ram_percent=$(free --mega | awk '$1 == "Mem:" {printf("%.2f", ($3/$2)*100)}')

    #heure du demarrage
    date=$(who -b | awk '{print $3 " " $4}')

    #cpu load
    vm=$(vmstat 1 2 | tail -1 | awk '{print $15}')
    cpuactive=$(expr 100 - $vm)
    #################

    yad --form --fixed --title="COLUMBA - Serveur" \
        --width=400 --height=200 --center \
        --image="../yoru.png" \
        --text="COLUMBA SERVER" \
        --button="DEMARRER:2" \
        --button="Quitter!exit:1"
    ACTION=$?
    if [ $ACTION -eq 2 ]; then
        $REPERTOIRE_DU_SCRIPT/server_script.sh &
        yad --form --fixed --title="COLUMBA - Serveur" \
        --width=400 --height=200 --center \
        --text="<b>COLUMBA SERVER</b>\n \
        Architecture : $arch\n \
        Demarrage du serveur : $date\n \
        Processeur physique : $cpup\n \
        Processeur virtual : $cpuv\n \
        Ram : $ram_used/$ram_total($ram_percent%)\n \
        Activite du cpu : $cpuactive%\n" \
        --button="ARRETER:2" \
        --button="Quitter!exit:1"
        ACTION1=$?
        if [ $ACTION1 -eq 1 ]; then
            echo "serveur arreter"
            killall -9 server_script.sh
            exit
        fi
        if [ $ACTION1 -eq 2 ]; then
            killall -9 server_script.sh
            echo "serveur arreter"
        fi
    fi
    if [ $ACTION -eq 1 ]; then
        echo "serveur arreter"
        exit 1
    fi
    #######################
done

#AFFICHAGE
echo "Architecture : $arch"
echo "Demarrage du serveur : $date"
echo "Processeur physique : $cpup"
echo "Processeur virtual : $cpuv"
echo "Ram : $ram_used/$ram_total($ram_percent%)"
echo "Activite du cpu : $cpuactive%"
