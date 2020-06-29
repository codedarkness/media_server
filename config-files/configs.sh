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

first_install() {
	echo ""
	echo " Getting ready to update the system"
	sleep 2;
	echo ""
	echo " This installation/update is for a new and fresh install"
	echo " of your media server (debian-based system)"

	while true; do
		read -p " Install/update system [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo apt update && sudo apt dist-upgrade -y && sudo apt install -y gnupg gnupg2 gnupg1 apt-transport-https ranger htop vim ;;
			[Nn]* )
				exit ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

wpa_supplicant() {
	echo ""
	echo " Setup Wifi"
	sleep 1;

	sudo apt-get install wpasupplicant &&
	echo " wpa_supplicant was installed" || echo " We have a problem!"
	echo ""

	echo " Edit wpa_supplicant.conf"
	sleep 1;
	cat config-files/txt/wpasupplicant >> sudo /etc/wpa_supplicant/wpa_supplicant.conf &&
	echo " Make all the necessary changes to fit your configuration" || echo " Upsss!"

	sleep 1;
	sudo vim /etc/wpa_supplicant/wpa_supplicant.conf
}

static_ip_address() {
	echo ""
	echo " Setup an static ip address"
	sleep 1;

	cat config-files/txt/staticip >> sudo /etc/network/interfaces &&
	echo " Make all necessary changes to fit your configuration" || echo " Holy... Something is wrong!"

	while true; do
		read -p " Setup an static ip address [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo vim /etc/network/interfaces ;;
			[Nn]* )
				exit ;;
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
	echo " DarknessCode"
	echo "   _____             __ _                       _   _                  "
	echo "  / ____|           / _(_)                     | | (_)                 "
	echo " | |     ___  _ __ | |_ _  __ _ _   _ _ __ __ _| |_ _  ___  _ __  ___  "
	echo " | |    / _ \| '_ \|  _| |/ _' | | | | '__/ _' | __| |/ _ \| '_ \/ __| "
	echo " | |___| (_) | | | | | | | (_| | |_| | | | (_| | |_| | (_) | | | \__ \ "
	echo "  \_____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|___/ "
	echo "                           __/ |                                       "
	echo "                          |___/ 					     "
	echo ""
	echo " Make some setups to your Debian-based system"
	echo ""
	echo " 1 - First Install (new fresh installation)"
	echo " 2 - Setup Wireless (wps_supplicant)"
	echo " 3 - Static ip address"
	echo " 4 - Name/Options"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; first_install     ;;
		2) clear; wpa_supplicant    ;;
		3) clear; static_ip_address ;;
		4) clear; Name/Options ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
