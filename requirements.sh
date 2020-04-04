#!/usr/bin/bash
sudo apt-get install unzip
sudo wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip 
unzip ngrok-stable-linux-amd64.zip 
wait
rm ngrok-stable-linux-amd64.zip
wait
sudo git clone https://gitlab.com/kalilinux/packages/cryptcat.git
wait
sudo apt-get install figlet
exit
