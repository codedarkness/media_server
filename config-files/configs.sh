#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _` | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _` |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: configs.sh
#       USAGE: ./configs.sh | sub menu of media_server.sh
#
# DESCRIPTION: make some configurations over your server
#
#      AUTHOR: Darknesscode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-28-20 3:56
#
# -----------------------------------------------------------------

static_ip_address() {
	echo ""
	echo " Setup an static ip address"
	sleep 1;

	while true; do
		read -p " Setup an static ip address [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo vim /etc/network/interfaces ;;
			[Nn]* )
				funcion ; exit 0 ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	sudo systemctl restart networking && echo " Done!" || echo " Upssss"


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
	echo " ----------------------------------------------"
	echo " ### Title here                             ###"
	echo " ----------------------------------------------"
	echo ""
	echo " 1 - Static IP address"
	echo " 2 - Name/Options"
	echo " 3 - Name/Options"
	echo " 4 - Name/Options"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; static_ip_address ; press_enter ;;
		2) clear; Name/Options ; press_enter ;;
		3) clear; Name/Options ; press_enter ;;
		4) clear; Name/Options ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
