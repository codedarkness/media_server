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
#        FILE: torrent_server.sh
#       USAGE: ./torrent_server.sh | sub menu of torrent_server.sh
#
# DESCRIPTION: install transmission over a headless server
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-24-20 4:23
#
# -----------------------------------------------------------------

install_transmission() {
	echo ""
	echo " Installing transmission"
	sleep 2;
	sudo add-apt-repository ppa:transmissionbt/ppa;
	sudo apt update;
	sudo apt install -y transmission-cli transmission-common transmission-deamon;
}

edit_transmission_automatic() {
	echo ""
	echo " Configure transmission"
	echo ""
	echo " Follow the instructios to setup your transmission"
	sleep 2;

	sudo service transmission-daemon stop;

	read -p " User name to connect to transsmission : " choice;
	sudo sed 's/"rpc-username": ".*",/"rpc-username": "'$choice'",/g' /etc/transmission-deamon/settings.json &&
	echo " The user name has been added" || echo " Did you broke somthing!"
	echo ""

	read -p " Password to connect to transmission : " choice;
	sudo sed 's/"rpc-password": ".*"/"rpc-password": "'$choice'",/g' /etc/transmission-deamon/settings.json &&
	echo " Password has ben setup" || echo " Something whent wrong!"
	echo ""

	read -p " Which is the full path of your download directory : " choice;
	sudo sed 's/"download-dir": ".*",/"download-dir": "'$choice'",/g' /etc/transmission-deamon/settings.json &&
	sudo sed 's/"incomplete-dir": ".*",/"incomplete-dir": "'$choice'",/g' /etc/transmission-deamon/settings.json &&
	sudo sed 's/"incomplete-dir-enabled": false,/"incomplete-dir-enables": true,/g' /etc/transmission-deamon/settings.json &&
	echo " The path has been setup" || echo " Upsss!"
	echo ""

	read -p " Which is the IP address of your local computer : " choice;
	sudo sed 's/"rpc-whitelist": "127.0.0.1",/"rpc-whitelist": "127.0.0.1,"'$choice'",/g' /etc/transmission-deamon/settings.json &&
	sudo sed 's/"umas": 12,/"umask": 2,/g' /etc/transmission-deamon/settings.json
	echo ""

	read -p " Server user name : " choice;
	sudo usermod -a -G debian-transmission $choice;
	echo " The user $choice has been added to debian-transmission group"

	sudo service trasmission-daemon start
}

edit_transmission_manual() {
	echo ""
	echo " Manual configurations of transmission"
	echo ""
	echo " You need to change this lines with your own settings"
	echo " rpc-password: your-password"
	echo " rpc-username: user name"
	echo " rpc-whitelist: 127.0.0.1,your.ip.address.local"
	echo " download-dir: /path/to/downloads/folder"
	echo " incomplete-dir: /path/to/incomplete/folder"
	echo " incomplete-dir-enabled: true"
	echo " umask 2"
	sleep 2;
	echo ""
	while true; do
		read -p " Do you want to continuo : " yn
		case $yn in
			[Yy]* )
				sudo service transmission-deamon stop;
				sudo vim /etc/transmission-daemon/settings.json
				sudo service transmission-deamon start
			[Nn]* )
				funcion ; exit 0 ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
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
	echo " Darknesscode"
	echo "  _______                            _         _             "
	echo " |__   __|                          (_)       (_)            "
	echo "    | |_ __ __ _ _ __  ___ _ __ ___  _ ___ ___ _  ___  _ __  "
	echo "    | | '__/ _' | '_ \/ __| '_ ' _ \| / __/ __| |/ _ \| '_ \ "
	echo "    | | | | (_| | | | \__ \ | | | | | \__ \__ \ | (_) | | | |"
	echo "    |_|_|  \__,_|_| |_|___/_| |_| |_|_|___/___/_|\___/|_| |_|"
	echo ""
	echo " Setup a torrent box and install a remote control for torrents"
	echo ""
	echo " 1 - Install Transmission"
	echo " 2 - Edit config.json automatic"
	echo " 3 - Edit config.json manually"
	echo " 4 - Readme"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install_transmission ; press_enter ;;
		2) clear; edit_transmission    ; press_enter ;;
		3) clear; Name/Options ; press_enter ;;
		4) clear; Name/Options ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
