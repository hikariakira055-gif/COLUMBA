#!/bin/bash

ip_user=$(ip a >> o && grep "inet " o >> p && awk '{print $2}' p |tail -1 >> a && awk -F '/' '{print $1}' a)
rm a o p

echo $ip_user

while true; do
    size=$(du -sh inbox | awk -F "K" '{print $1}')
    if [ $size != "4,0" ]; then 

        for file in ./inbox/*.in; do 

            echo "$file"
            
            uss=$(head -1 $file)

            ping -c 3 $uss > a
            ping_result1=$(awk -F "" '{print $1}' a | head -4 | tail -1)
            rm a


            if [ $ping_result1 = "6" ]; then
                echo "votre correspondant est disponible !"

                ncat $uss 5555 < $file

            else
                echo "votre correspondant n'est pas disponible !"
            fi

        done

    fi

done
