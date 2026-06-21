#!/bin/bash



echo -e "\e[35m$(cat src/test.tx)\e[0m"


BLUE=$'\e[34m'
RED=$'\e[31m'
GREEN=$'\e[32m'

CYAN=$'\e[36m'
VIOLET=$'\e[38;5;129m'
BOLD=$'\e[1m'

RESET=$'\e[0m'


echo -ne "[ ██             ] Uninstall ...\r"
sleep 1
echo -ne "[ ████           ] Uninstall ...\r"
sleep 1
sudo rm /usr/local/bin/columba &> /dev/null
sudo rm /usr/local/bin/columba_srv &> /dev/null
echo -ne "[ ████████       ] Uninstall ...\r"
sleep 1
echo -ne "[ ██████████     ] Uninstall ...\r"
sleep 1
echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} Uninstall was successfull ${RESET}"

# L'option -n évite le saut de ligne, -e active les caractères comme \r



# if [ "$choix" -eq "Y" ]; then



# elif [ "$cjoix" -eq "n" ]; then


# fi

echo "${GREEN}desinstallation termine avec succes !${GREEN}"