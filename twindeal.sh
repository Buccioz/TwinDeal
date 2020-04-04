#!/usr/bin/bash
#      ███      ▄█     █▄   ▄█  ███▄▄▄▄        ████████▄     ▄████████    ▄████████  ▄█       
#  ▀█████████▄ ███     ███ ███  ███▀▀▀██▄      ███   ▀███   ███    ███   ███    ███ ███       
#     ▀███▀▀██ ███     ███ ███▌ ███   ███      ███    ███   ███    █▀    ███    ███ ███       
#      ███   ▀ ███     ███ ███▌ ███   ███      ███    ███  ▄███▄▄▄       ███    ███ ███       
#      ███     ███     ███ ███▌ ███   ███      ███    ███ ▀▀███▀▀▀     ▀███████████ ███       
#      ███     ███     ███ ███  ███   ███      ███    ███   ███    █▄    ███    ███ ███       
#      ███     ███ ▄█▄ ███ ███  ███   ███      ███   ▄███   ███    ███   ███    ███ ███▌    ▄ 
#     ▄████▀    ▀███▀███▀  █▀    ▀█   █▀       ████████▀    ██████████   ███    █▀  █████▄▄██ 
#                                                                                   ▀          Developed by Buccioz

printf '\e[8;50;100t'

if [ "$EUID" -ne 0 ]
     
  then echo "Not running as root..." 
  echo ""

  #forcing running as root-------------------------------------------------
  sudo "$0" "$@"
  exit
  fi
 
 FILE=ngrok
 if [ -f "$FILE" ]; then
    echo "$FILE exist..."
    echo                              
  #checking if ngrok is been installed in this directory------------------------------------------
else 
    echo "$FILE does not exist..."
    chmod +x requirements.sh
    xterm -e ./requirements.sh  
wait
fi

  clear 
#------------------------
  chmod +x ./banner.sh
 ./banner.sh
  echo;
 while true
 do
 PS3=' ' 
 options=("Host" "Connect" "Exit")
 select opt in "${options[@]}" 

 do
     case $opt in
         "Host")
                                                
           echo "";
           echo "";
   #starting server---------------------------------------------------- 
           clear
           echo "Starting server...";
           echo 
           echo "Local Host:" $(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p');
           read -p 'Local Port:' porthost
           clear
   #opening ngrok -----------------------------------------------------
            xterm -e ./ngrok tcp $porthost &
              
   #start listening----------------------------------------------------
           mawk -W interactive '$0="Host: "$0' | cryptcat -vv -i 1 -l -p $porthost;
           break
           ;;
         "Connect")
             echo 
   #Starting cryptocat--------------------------------------------------
             echo "Starting Cryptocat...";
             echo 
             read -p 'Address:' tcpclient
             read -p 'Port:' portclient 
             echo
             mawk -W interactive '$0="Client: "$0' | cryptcat -vv $tcpclient $portclient;
             break
             ;;
            "Exit")

             echo "Exiting..."                 
             exit
             ;;
         *) echo invalid option;;
     esac
 done
 done
