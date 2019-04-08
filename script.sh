#!/bin/bash
apt-get update
sudo apt install net-tools
sudo apt install nmap
sudo apt-get install fail2ban
sudo apt-get install ccrypt


clear
RETVAL=$(whiptail --title "Make a selection | CHANGE DEFAULT PASSWORD ASAP option (d)" \
--menu --nocancel "Menu Script" 10 50 4 \
"a" "Scan Network using Nmap" \
"b" "Show the partition Table & Free Diskspace" \
"c" "Make SSH Server" \
"d" "Change RPI Password" \
"e" "THC Hydra Password cracking" \
"f" "Encryption / Decrption" \
"g" "WiFi Cracking Airgeddon" \
"h" "Ethercap WiFi Packet capturing" \
3>&1 1>&2 2>&3)

# Below you can enter the corresponding commands

case $RETVAL in
    a) echo "You selected to use Nmap"
       echo "nmap -sP address"
       read -p "Enter IP address: " IP
       nmap -sP $IP;;

    b) echo "<CMD> sudo fdisk -l && df"
       sudo fdisk -l && echo "" && df;;
    c) echo "Create and Start SSH Server"
    sudo systemctl enable ssh
    sudo systemctl start ssh
    cd /etc/ssh/
    grep Port sshd_config
    sudo sed -i 's/#Port 22/Port 2947/g' /etc/ssh/sshd_config
    sudo systemctl restart ssh

clear
    echo "Success SSH server has started please port forward port : 2947"

echo "Connect using IP: "$STR
STR= ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo "Port : 2947"



    read -r -p "Your SSH Server is vulnerable do you want to fix it? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
read -n 1 -r -s -p $'We will use fail2ban for a detailed guide follow | https://youtu.be/_XcPW9x8M8s?t=129 | Press any key to continue...\n'
        sudo nano /etc/fail2ban/jail.conf
        read -n 1 -r -s -p $'You need a restart after that let me do it for you... i need you to press a key...\n'
	sudo reboot
    else
        read -n 1 -r -s -p $'Dont say i didnt warn you! | Also you need to restart let me do it for you... Press a Key...\n'
	sudo reboot
    fi;;

    d) echo "Change Your Credidentials"
       sudo passwd;;

    e)
    apt-get install libssl-dev libssh-dev libidn11-dev libpcre3-dev \
                 libgtk2.0-dev libmysqlclient-dev libpq-dev libsvn-dev \
                 firebird-dev
    sudo apt-get install hydra-gtk
    sudo hydra
    ;;

    f)  echo "You selected to Encrypt / Decrption"
        echo "EXAMPLE to Encrypt : ccencrypt ~/Desktop/Tecmint/tecmint.txt"
        echo "EXAMPLE to Decrption : ccdecrypt ~/Desktop/Tecmint/tecmint.txt.cpt"


        read -r -p "Do you want to Encrypt? [y/N] " RESPONSECRYPO
        if [[ "$RESPONSECRYPO" =~ ^([yY][eE][sS]|[yY])+$ ]]
        then
              read -p "Enter File Path " ENCRYPT
              ccencrypt $ENCRYPT

        else
              read -p "Enter File Path " DECRYPT
              ccdecrypt $DECRYPT
        fi;;

    g) echo "You chose to use Airgeddon please add the kali repositories and enable all others"

	echo "cd /etc/apt/"
	echo "sudo nano sources.list"
	echo "deb http://http.kali.org/kali kali-rolling main non-free contrib"
	echo "deb-src http://http.kali.org/kali kali-rolling main non-free contrib"
	read -n 1 -r -s -p $'Press any key to continue.../n'

    sudo apt-get install xterm
    sudo apt-get install aircrack-ng
    sudo apt-get install isc-dhcp-server
    sudo apt-get install reaver
    sudo apt-get install dsniff
    sudo apt-get install hostapd
    sudo apt-get install sslstrip
    sudo apt-get install expect
    sudo apt-get install lighttpd
    sudo apt-get install crunch
    sudo apt-get install hashcat
    sudo apt-get install pixiewps
    sudo apt-get install john
    sudo apt-get install beef-xss
    sudo apt-get install wash
    sudo apt-get install bully
    sudo apt-get install mdk4
    sudo apt-get install ettercap-text-only
    sudo apt-get install hostapd-wpe
    sudo apt-get install asleap

    git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
    cd airgeddon/
    sudo bash airgeddon.sh;;

    h)
    sudo apt-get install ettercap-text-only
    read -p "What Interface: " InterfaceETT
    #read -p "What Mode: " ModeETT
    read -p "What File Name : " filename
    sudo ettercap -T -i $InterfaceETT -w $filename;;



    *) echo "Invalid option. Quitting";;
esac
