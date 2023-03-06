#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function help_panel(){
	echo -e "\n[+] Use: "
	echo -e "\t${redColour} ${endColour} ${grayColour}Escaneo de puertos locales (ejecutar sin argumentos) ${endColour}"
}


function ctrl_c(){
echo -e "\n\n[!] c...\n"
tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT

tput civis # hidden cursor
function search_ports() {
    for port in $(seq 1 65535); do
(echo '' > /dev/tcp/127.0.0.1/$port) 2>/dev/null && echo "[+] $port - OPEN" &
done; wait
}

declare -i  parameter_counter=0

# args
while getopts "h" arg  ;do
	case $arg in
		h) let parameter_counter+=1;;
	esac
done;


if [ $parameter_counter -eq 0 ]; then
    echo -e "\n ${redColour} Escaneando puertos locales ${endColour} "
	  search_ports
else
	help_panel
fi


# restore cursor
tput cnorm
