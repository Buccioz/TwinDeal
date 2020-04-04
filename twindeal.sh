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

  #forcing running as root-----------------------------------------------------------------------
  sudo "$0" "$@"
  exit
  fi
 #checking if ngrok is been installed in this directory------------------------------------------
 FILE=ngrok
 if [ -f "$FILE" ]; then
    echo "$FILE exist..."
    echo                              
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
      
     read -r -p 'Do you want add a different secretkey instead of the default one(y/n)?' response
     case "$response" in 
     ([sS]|[yY]) 
     echo "Client needs to know the secretkey";
     echo
     echo -n 'Secretkey: '; stty -echo; read secrkhst; stty echo; echo   
     clear
     mawk -W interactive '$0="\033[91mHost\a\033[0m: "$0' | cryptcat -l -vv -i 1 -k $secrkhst -p $porthost 
     clear
     ./banner.sh
     ;;
    *)  
     clear
     mawk -W interactive '$0="\033[91mHost\a\033[0m: "$0' | cryptcat -vv -i 1 -l -p $porthost 
     clear  
     ./banner.sh
     esac
     break
     ;;
     
         "Connect")
             echo 
             clear
   #Starting cryptocat--------------------------------------------------
             echo "Starting Cryptocat...";
             echo 
             read -p 'Address:' tcpclient
             read -p 'Port:' portclient

              read -r -p 'Do you want add a different secretkey instead of the default one(y/n)?' responsecl
              echo    # (optional) move to a new line
              case "$responsecl" in 
              ([sS]|[yY]) 
              echo -n 'Secretkey: '; stty -echo; read secrkcln; stty echo; echo
              clear
              mawk -W interactive '$0="\033[91mClient\a\033[0m: "$0' | cryptcat -k $secrkcln -vv $tcpclient $portclient 

              clear
              ./banner.sh
              ;;
             *)
              clear
              mawk -W interactive '$0="\033[91mClient\a\033[0m: "$0' | cryptcat -vv $tcpclient $portclient 
              clear
              ./banner.sh
              esac
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
