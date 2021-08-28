#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: configs.sh
#       USAGE: ./configs.sh | sub menu of media_server.sh
#
# DESCRIPTION: make some configurations over your server
#
#      AUTHOR: Darknesscode
#       EMAIL: achim@darknesscode.xyz
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
				sudo apt update && sudo apt dist-upgrade -y && sudo apt install -y gnupg gnupg2 gnupg1 apt-transport-https ranger htop vim unzip curl rsync ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

install_wpa_supplicant() {
	echo ""
	echo " Installing wpa_supplicant for wifi networks"
	sleep 2;

	sudo apt-get install -y wpasupplicant &&
	echo " wpa_supplicant was installed" || echo " We have a problem!"
	echo ""
}

add_wpa_supplicant() {
	echo ""
	echo " Setup Wifi Network"
	echo ""
	sleep 2;

	while true; do
		read -p " Edit wpa_supplicant.conf [y - n] : " yn
		case $yn in
			[Yy]* )
				cat config-files/txt/wpasupplicant.txt | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf &&
				echo " Make all the necessary changes to fit your configuration" || echo " Upsss!" ;

				sleep 2;

				sudo vim /etc/wpa_supplicant/wpa_supplicant.conf; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""
	echo " Is recomend to restart you computer/server"
	echo ""

	while true; do
		read -p " Reboot you computer/server [y - n] : " yn
		case $yn in
			[Yy]* )
				echo " Rebooting you computer now";
			        sudo reboot;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

static_ip_address() {
	echo ""
	echo " Setup an static ip address"
	sleep 2;

	while true; do
		read -p " Edit interfaces [y - n] : " yn
		case $yn in
			[Yy]* )
				cat config-files/txt/staticip.txt | sudo tee -a /etc/network/interfaces &&
				echo " Make all necessary changes to fit your configuration" || echo " Holy... Something is wrong!";

				sleep 2;

				sudo vim /etc/network/interfaces;

				sudo systemctl restart networking && echo " Done!" || echo " Upssss"; break;;
			[Nn]* )
				break ;;
			*) echo " Please answer yes o no."
		esac
	done

	echo ""
	echo " Is recomended to reboot your computer/server"
	echo ""

	while true; do
		read -p " Reboot you computer/server [y - n] : " yn
		case $yn in
			[Yy]* )
				echo " Rebooting you computer now";
			        sudo reboot;;
			[Nn]* )
				break ;;
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
	echo " 2 - Install wps_supplican"
	echo " 3 - Setup Wireless network (wps_supplicant)"
	echo " 4 - Static ip address"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; first_install         ; press_enter ;;
		2) clear; install_wpa_spplicant ; press_enter ;;
		3) clear; add_wpa_supplicant    ; press_enter ;;
		4) clear; static_ip_address     ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
