#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: samba_server.sh
#       USAGE: ./samba_server.sh | sub menu of media_server.sh
#
# DESCRIPTION: install samba to share files/directories in your
#              network
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-30-20 08:18
#
# -----------------------------------------------------------------

install_samba() {
	echo ""
	echo " Installing Samba"
	sleep 1;

	sudo apt install -y samba samba-common-bin

	read -p " Server user name for samba : " choice;
	sudo sbmpasswd -a $choice
	echo ""
	echo " The usar name has been added to samba group"
}

set_up_share() {
	echo ""
	echo " Getting ready to setup samba"
	echo ""
	echo " Make all the necessary changes to fit your own configuration"
	echo " at the end of the smb.conf is a sample share, if you need more"
	echo " than one share just copy and past to do a new share"
	echo ""

	echo " Getting ready to edit smb.conf"
	sleep 2;
	cat config-files/txt/samba.txt | sudo tee -a /etc/samba/smb.conf > /dev/null &&
	echo  " Sample share is ready, open file..." | echo " Upsss... something is wrong with you!"
	echo ""

	sudo vim /etc/samba/smb.conf

	echo " Restarting samba service"
	sudo service smbd restart
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "   _____                 _            "
	echo "  / ____|               | |           "
	echo " | (___   __ _ _ __ ___ | |__   __ _  "
	echo "  \___ \ / _' | '_ ' _ \| '_ \ / _' | "
	echo "  ____) | (_| | | | | | | |_) | (_| | "
	echo " |_____/ \__,_|_| |_| |_|_.__/ \__,_| "
	echo ""
	echo " Install a server share file"
	echo ""
	echo " 1 - Install Samba"
	echo " 2 - Setup a share directory"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install_samba ; press_enter ;;
		2) clear; set_up_share  ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
