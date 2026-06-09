#!/bin/bash
#pkill -f ncat
ip_user=$(ip a >> o && grep "inet " o >> p && awk '{print $2}' p |tail -1 >> a && awk -F '/' '{print $1}' a)
rm a o p
./slisten.sh >/dev/null 2>&1 &
echo $ip_user

while true; do
    
    if [ $(ls inbox | wc -l) -gt 0 ]; then

        for file in ./inbox/*.in; do 

            echo "$file"
            
            if [ ! -f "$file" ]; then continue; fi

            uss=$(head -1 $file)

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
