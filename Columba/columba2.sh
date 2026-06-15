#!/bin/bash
export GDK_BACKEND=x11

cd client
./clisten.sh >/dev/null 2>&1 &
cd ..

CONF_FILE="./config/config.conf"
TMP=$(cat $CONF_FILE | awk '$1 == "BG_IMG:" {print $2}')
ICONS=$(cat $CONF_FILE | awk '$1 == "ICON_IMG:" {print $2}')
SERVER_PORT=$(cat $CONF_FILE | awk '$1 == "SERVER_PORT:" {print $2}')
LISTEN_PORT=$(cat $CONF_FILE | awk '$1 == "LISTEN_PORT:" {print $2}')
WRITE_BG=$(cat $CONF_FILE | awk '$1 == "WRITE_BG:" {print $2}')
MAIL=$(cat $CONF_FILE | awk '$1 == "MAIL:" {print $2}')

FICHIER_BG=$TMP


#if [ -d "$FICHIER_INBOX" ];then
	#echo "$(date +%d/%m)|Akira|Re: test|Salut" > "$FICHIER_INBOX"
        #echo "$(date +%d/%m)|Yuto|test 2|Whassup man" >> "$FICHIER_INBOX"
#fi


	pseudo=$(echo "$connexion" | cut -d'|' -f1)
while true; do

	yad --form --fixed --title="COLUMBA -Menu Principal" \
        --window-icon="$ICONS" \
	    --image="$FICHIER_BG" \
	    --width=400 --height=200 --center \
	    --text="<b>Bienvenu dans votre messagerie</b>\nV1.0 Copyright\n Yoru" \
		--button="Other:4" \
	    --button="Boite de Réception!mail-read:2" \
	    --button="Rédiger un message!mail-send:3" \
	    --button="Quitter!exit:1"
	ACTION=$?
	if [ $ACTION -eq 4 ];then

		
		CHOIX1=$(yad --list --fixed --title="Columba" \
					--window-icon="$ICONS" \
					--width=500 --height=600 --center \
					--column="list" \
					"Server list" "Calendar" "Notebook"\
					--button="Back"
		)
		CHOIXX=$(echo "$CHOIX1" | cut -d'|' -f1)
		echo "$CHOIXX"

		if [ "$CHOIXX" = "Calendar" ]; then

			THEDATE=$(yad --calendar --window-icon="$ICONS" --center)

		elif [ "$CHOIXX" = "Notebook" ]; then
			
			text=$(yad --form --title="Notebook" \
						--window-icon="$ICONS" \
						--width=700 --height=400 --center \
						--field="Text:TXT" "" \
						--button="Save:1" --button="Back:0")
			if [ $? -eq 1 ]; then
				path=$(yad --file --save)

				echo -e $text

			fi
		elif [ "$CHOIXX" = "Server list" ];then
			echo "things"

			
		fi

	fi
	if [ $ACTION -eq 1 ];then
		echo "Fermeture de l'application."
		pkill -f ncat
		killall -9 clisten.sh
		fuser -9 -k $SERVER_PORT/tcp 50001/tcp
		exit 0
	fi
	#Écoute en attente de message
	if [ $ACTION -eq 2 ];then
	declare -A tab
		FICHIER_INBOX="./client/inbox__"
		i=1
		for file in ./client/inbox/*.in; do 
			
			# date=$(awk '$1 == "ip:" {print $4}' $file) 
			# ip=$(awk '$1 == "ip:" {print $2}' $file)

			# msg=$("$date|$ip")
			tab[$i]=$file
			echo $i >> $FICHIER_INBOX
			awk '$1 == "ip:" {print $4}' $file >> $FICHIER_INBOX
			awk '$1 == "ip:" {print $2}' $file >> $FICHIER_INBOX
			awk '$1 == "ip:" {print $6}' $file >> $FICHIER_INBOX
			awk '$1 == "ip:" {print $8}' $file >> $FICHIER_INBOX
			echo 
			# grep -v "ip:" $file >> $FICHIER_INBOX
			((i+=1))
			# echo "\n" >> $FICHIER_INBOX
        done


		CHOIX=$(yad --list --fixed --title="COLUMBA - Boite de reception" \
			--window-icon="$ICONS" \
			--image="$MAIL" \
			--width=600 --height=600 --center \
			--text="<b>Mail INBOX</b>\nFami" \
			--column="No" --column="Date" --column="Pour" --column="Objet" --column="De" \
			$(cat "$FICHIER_INBOX" | tr '|' '\n') \
			--button="Retour au menu:1")
			echo "" > $FICHIER_INBOX

			echo $CHOIX
		if [ ! -z "$CHOIX" ];then
			No=$(echo "$CHOIX" | cut -d'|' -f1)
			date=$(echo "$CHOIX" | cut -d'|' -f2)
			expediteur=$(echo "$CHOIX" | cut -d'|' -f3)
			objet=$(echo "$CHOIX" | cut -d'|' -f4)
			from=$(echo "$CHOIX" | cut -d'|' -f5)
			message=$(cat ${tab[$No]} | grep -v "ip:")
			yad --title="Message de $expediteur" \
			    --width=500 --height=300 --center \
			    --text="Sujet: $objet\nDate : $date\nDe: $from\n════════════════════════════════════════════════════════════\n$message " \  
		fi
	fi
	#Envoi du message apprès avoir écris l'ip du destinataire
	if [ $ACTION -eq 3 ];then

		courrier=$(yad --form --fixed --title="Nouveau Message" \
			--window-icon="$ICONS" \
			--width=400 --height=600 --center \
			--image="$WRITE_BG" \
			--text="<b>Email writer</b>\nMAKIMA" \
			--field="De" "" \
			--field="Pour(IP)" "" \
			--field="Addresse du serveur" "" \
			--field="Objet" "" \
			--field="Message:TXT" "" \
			--button="Annuler:1" --button="Envoyer!mail-send:0")

		if [ $? -eq 0 ];then
			name=$(echo "$courrier" | cut -d'|' -f1)
			dest=$(echo "$courrier" | cut -d'|' -f2)
			srv=$(echo "$courrier" | cut -d'|' -f3)
			obj=$(echo "$courrier" | cut -d'|' -f4)
			texte=$(echo "$courrier" | cut -d'|' -f5 | tr '\n' ' ')
			#echo "$(date +%d/%m)|Moi (vers $dest)|$sujet|$texte" >> "$FICHIER_INBOX"
			

			set counter=0
			#localhost: tokony hatao ny addressen'le serveur
			ping -c 5 $srv > a
			check=$(cut -d' ' -f1 a | head -n 6)
			rm a
			for val in $check;
			do
				if [ $val="64" ];then
					counter=$((counter+1))
				fi
			done
				if [ $counter="6" ];then
					yad --text="le serveur est disponible"

					# touch msg_
					date=$(date +%d-%m-%Y)
					echo "ip: $dest date: $date obj: $obj De: $name" > msg_
					echo " " >> msg_
					echo $texte >> msg_
					
					ncat $srv $SERVER_PORT < msg_ 
					#rm msg_


				else
					yad --text="Désolé mais le serveur n'est pas disponible"
				fi


		fi
	fi
done
			  
