#!/bin/bash

#---------------------------------------------------------------------------------#
#----------This script is made by Yash Patidar----------------------#
#----------Before running this script make sure you have all the requirements---------------#
#----------Install nmap,nikto,dirsearch-----------#
#----------if you do not have dirsearch then this script will use dirb for directory busting----#                       
#---------------------------------------------------------------------------------#


#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

# Check entered ip is correct or not
RED='\033[0;31m'
GREEN='\033[0;32m'
PURLE='\033[0;35m'
if [ -z "$1" ]; then
  echo -e "${RED} [+] Usage: ${GREEN} <IP Address>"
  exit 1
fi

# check if packages are installed

if [ ! type nmap &> /dev/null ]; then
  echo "                                            "
  echo "Please install nmap and rerun the script."
  echo "                                            "
  exit 0
fi

if [ ! type nikto &> /dev/null ]; then
  echo "                                            "
  echo "Please install nikto and rerun the script."
  echo "                                            "
  exit 0
fi

if [ ! locate dirsearch &> /dev/null ]; then
  echo "                                            "
  echo "Please install dirsearch"
    echo " for this script we are using dirb"
  VAR=1
  else
   VAR=2 
fi
if [ ! type dirb &> /dev/null ]; then
  echo "                                            "
  echo "Please install dirb and rerun the script."
  echo "                                            "
  exit 0
fi

# go ahead and start scanning     
   
echo    "                                          "
echo -e "${PURPLE}#----------------------------------#"
echo -e "${PURPLE}#          \e[36m   TCP Scan  \e[35m           #"
echo -e "${PURPLE}#----------------------------------#"
echo    "                                          "
echo -e "${PURPLE}"

nmap -Pn -p- -A $1 -r -n --open

echo    "                                          "
echo -e "${PURPLE}#----------------------------------#"
echo -e "${PURPLE}#          \e[36m  Nikto Scan  \e[35m          #"
echo -e "${PURPLE}#----------------------------------#"
echo    "                                          "
echo -e "${PURPLE}"

nikto -h http://$1/

echo "                            "

nikto -h https://$1/

#directory searching
if [[ $VAR -eq 1 ]]
then
echo    "                                          "
echo -e "${PURPLE}#----------------------------------#"
echo -e "${PURPLE}#---------\e[36m   Dirsearch Scan  \e[35m          #"
echo -e "${PURPLE}#----------------------------------#"
echo    "                                          "
echo -e "${PURPLE}"
python3 dirsearch.py -u http://$1 -x 400,401,403
echo "                            "
	
python3 dirsearch.py -u https://$1 -x 400,401,403
else
	echo    "                                          "
	echo -e "${PURPLE}#----------------------------------#"
	echo -e "${PURPLE}#          \e[36m   Dirb Scan  \e[35m          #"
	echo -e "${PURPLE}----------------------------------#"
	echo    "                                          "
	echo -e "${PURPLE}"
	dirb http://$1/ /usr/share/wordlists/dirb/big.txt
	
	echo "                            "
	
	dirb https://$1/ /usr/share/wordlists/dirb/big.txt
fi

