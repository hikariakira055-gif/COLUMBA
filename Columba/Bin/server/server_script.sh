#!/bin/bash
#pkill -f ncat
ip_user=$(ip a >> o && grep "inet " o >> p && awk '{print $2}' p |tail -1 >> a && awk -F '/' '{print $1}' a)
REPERTOIRE_DU_SCRIPT="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
rm a o p
"command $REPERTOIRE_DU_SCRIPT/slisten.sh >/dev/null" 2>&1 &
echo $ip_user

while true; do
    
    if [ $(ls "$REPERTOIRE_DU_SCRIPT/inbox" | wc -l) -gt 0 ]; then

        for file in $REPERTOIRE_DU_SCRIPT/inbox/*.in; do 

            echo "$file"
            
            if [ ! -f "$file" ]; then continue; fi

            uss=$(awk '$1 == "ip:" {print $2}' $file)

            ping -c 3 $uss > a
            ping_result1=$(awk -F "" '{print $1}' a | head -4 | tail -1)
            rm a


            if [ $ping_result1 = "6" ]; then
                echo "votre correspondant est disponible "

                ncat $uss 50001 < $file
                rm $file

            else
                echo "votre correspondant nest pas disponible "
            fi

        done

    else
        echo "There is nothing to treat"
    fi

done
