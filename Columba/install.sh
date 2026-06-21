#!/bin/bash



echo -e "\e[35m$(cat src/test.tx)\e[0m"


BLUE=$'\e[34m'
RED=$'\e[31m'
GREEN=$'\e[32m'

CYAN=$'\e[36m'
VIOLET=$'\e[38;5;129m'
BOLD=$'\e[1m'

RESET=$'\e[0m'



# L'option -n évite le saut de ligne, -e active les caractères comme \r
echo -ne "[ ██             ] Checking dependencies ...\r"
if command -v ncat &> /dev/null; then
    NCAT="Reinstalling"
else
    NCAT="Installing"
fi
sleep 2
echo -ne "[ ██████         ] Checking dependencies ...\r"
if command -v yad &> /dev/null; then
    YAD="Reinstalling"
else
    YAD="Installing"
fi
sleep 2
echo -ne "[ ██████████     ] Checking dependencies ...\r"
sleep 2
echo -e  "${GREEN}[ ██████████████ ] ${BLUE} Checking dependencies done${RESET}" 
echo " "


			#localhost: tokony hatao ny addressen'le serveur
if ping -c 5 8.8.8.8 &> /dev/null; then

    echo -ne "[ ██             ] Testing the network .\r"
    sleep 1
    echo -ne "[ ████           ] Testing the network ..\r"
    sleep 1
    echo -ne "[ ████████       ] Testing the network ...\r"
    sleep 1
    echo -ne "[ ██████████     ] Testing the network ....\r"
    sleep 1
    echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} ${BOLD} Testing was a SUCCESS ${RESET}"
    echo " "

    if command -v pacman &> /dev/null; then #Arch

    sudo pacman -Sy --needed yad nmap --noconfirm 1> /dev/null 2> /dev/null

    echo -ne "[ ██             ] $NCAT ncat ...\r"
    sleep 1
    echo -ne "[ ████           ] \r"
    sleep 1
    echo -ne "[ ████████       ] $YAD yad ...\r"
    sleep 1
    echo -ne "[ ██████████     ] \r"
    sleep 1
    echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} All dependencies is installed ... ${RESET}"
    


    elif command -v apt-get &> /dev/null; then #Debian/Ubuntu

        sudo apt-get update && sudo apt-get install -y nmap yad 1> /dev/null 2> /dev/null

        echo -ne "[ ██             ] $NCAT ncat ...\r"
        sleep 1
        echo -ne "[ ████           ] \r"
        sleep 1
        echo -ne "[ ████████       ] $YAD yad ...\r"
        sleep 1
        echo -ne "[ ██████████     ] \r"
        sleep 1
        echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} All dependencies is installed ... ${RESET}"
        

    elif command -v dnf &> /dev/null; then #Fedora

        sudo dnf install -y nmap yad 1> /dev/null 2> /dev/null

        echo -ne "[ ██             ] $NCAT ncat ...\r"
        sleep 1
        echo -ne "[ ████           ] \r"
        sleep 1
        echo -ne "[ ████████       ] $YAD yad ...\r"
        sleep 1
        echo -ne "[ ██████████     ] \r"
        sleep 1
        echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} All dependencies is installed ... ${RESET}"
        

    elif command -v zypper &> /dev/null; then #OpenSUSE

        sudo zypper install -y nmap yad 1> /dev/null 2> /dev/null

        echo -ne "[ ██             ] $NCAT ncat ...\r"
        sleep 1
        echo -ne "[ ████           ] \r"
        sleep 1
        echo -ne "[ ████████       ] $YAD yad ...\r"
        sleep 1
        echo -ne "[ ██████████     ] \r"
        sleep 1
        echo -e "${GREEN}[ ██████████████ ]${RESET} ${BLUE} All dependencies is installed ... ${RESET}"
        

    else
        echo "${RED}Gestionnaire de paquets introuvable.${RESET}"
        exit 1
    fi

    echo " "
    echo -n "${BLUE}::${RESET} ${BOLD}Installation - Did you want to install Columba on your system ${RESET} [${GREEN}Y${RESET}/${RED}n${RESET}] : "
    read choix

    
    if [ "$choix" = "Y" ]; then

        sudo ln -s "$PWD/Bin/columba2.sh" /usr/local/bin/columba
        sudo ln -s "$PWD/Bin/server/server.sh" /usr/local/bin/columba_srv

    elif [ "$choix" = "n" ]; then

        echo "${RED}:: ${BOLD} Abandon ${RESET}"

    fi


else

    echo -ne "[ ██             ] Testing the network .\r"
    sleep 1
    echo -ne "[ ████           ] Testing the network ..\r"
    sleep 1
    echo -ne "[ ████████       ] Testing the network ...\r"
    sleep 1
    echo -ne "[ ██████████     ] Testing the network ....\r"
    sleep 1
    echo -e "${RED}[ ██████████████ ]${RED} ${RED} ${BOLD} Testing was a FAILURE. Please connect to a network and try again ${RESET}"

fi







# if [ "$choix" -eq "Y" ]; then



# elif [ "$cjoix" -eq "n" ]; then


# fi

# echo "${GREEN}Installation termine avec succes !${GREEN}"