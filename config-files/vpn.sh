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
#        FILE: vpn.sh
#       USAGE: ./vpn.sh | sub menu of media_server.sh
#
# DESCRIPTION: install con configure a vpn in your debian-based
#              server
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-28-20 3:48
#
# -----------------------------------------------------------------

install_openvpn() {
	echo ""
	echo " Installing openVPN"
	sleep 1;

	sudo apt install -y openvpn
}

setup_pia() {
	echo ""
	echo " Getting ready to copy/download all necesary files"
	echo ""
	echo " Private Internet Access"
	echo ""
	sleep 2;

	echo " Copy new files"
	sudo cp -i config-files/txt/pingtest.sh /usr/local/bin/ &&
	echo " Ping test files has been copied" || echo " Upsss!"
	echo ""

	sudo cp -i config-files/txt/ovpnstart.sh /usr/local/bin/ &&
	echo " Auto start files has been copied" || echo " Holy..."
	echo ""

	cd /etc/openvpn &&
	echo " Switching to openvpn directory" || echo " Sh.... Something's bad"
	echo ""
	pwd
	echo ""

	sudo wget https://www.privateinternetaccess.com/openvpn/openvpn.zip &&
	sudo unzip openvpn.zip && sudo rm openvpn.zip &&
	echo " pia files where download" || echo "Upsss! who knows"
	echo ""
}

setup_password() {
	echo ""
	echo " Creating a pass.txt file"
	echo ""
	echo " Add usarname in line 1"
       	echo " Add password in line 2"
	sleep 2;
	echo ""

	while true; do
		read -p " Create pass.txt for authentication [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo vim /etc/openvpn/pass.txt; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""
}

setup_server() {
	echo ""
	echo " Setup the vpn-server of your choice"
	echo ""

	(cd /etc/openvpn/ && ls *.ovpn)
	echo ""
	sleep 2;

	echo " Select the vpn server of you choice/region"
	echo " Write the name of the server you like, but without extention"
	echo " and write it with capitals and blank spaces, like this:"
	echo " US New York City or CA Montrial"
	echo ""

	read -p " vpn server to use : " choise;
	sudo sed -i 's+auth-user-pass+auth-user-pass /etc/openvpn/pass.txt+g' /etc/openvpn/$choice.ovpn &&
	sudo sed -i "s+/etc/openvpn/.*.ovpn+/etc/openvpn/$choice.ovpn/g" /usr/local/bin/ovpnstart.sh &&
	echo " the vpn server has been setup" || echo "Huston we have a problem!"
	echo ""
}

cronjob() {
	echo ""
	echo " Creating cronjob"
	echo " Add this to lines to the crontab"
	echo ""
	echo " @reboot /usr/local/bin/ovpnstart.sh"
	echo " @hourly /usr/local/bin/pingtest.sh"
	echo ""
	echo " The fitst line will start our vnp at boot"
	echo " The second line will check every hour if the vpn is runnin"
	echo ""

	while true; do
		read -p " Add a cronjob [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo crontab -e;
				echo " Now reboot your server/computer and check if everything works as spected"; break ;;
			[Nn]* )
				echo " Until next time"; break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""
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
	echo " DarnessCode"
	echo "                     __      _______  _   _  "
	echo "                     \ \    / /  __ \| \ | | "
	echo "   ___  _ __   ___ _ _\ \  / /| |__) |  \| | "
	echo "  / _ \| '_ \ / _ \ '_ \ \/ / |  ___/| . ' | "
	echo " | (_) | |_) |  __/ | | \  /  | |    | |\  | "
	echo "  \___/| .__/ \___|_| |_|\/   |_|    |_| \_| "
	echo "       | |                                   "
	echo "       |_|   				   "
	echo ""
	echo " Install openvpn and setup internet private access"
	echo ""
	echo " 1 - Install openVPN"
	echo " 2 - Copy/Download PIA files"
	echo " 3 - User and password for PIA"
	echo " 4 - Setup vpn server"
	echo " 5 - Add a cronjob"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install_openvpn ; press_enter ;;
		2) clear; setup_pia       ; press_enter ;;
		3) clear; setup_password  ; press_enter ;;
		4) clear; setup_server    ; press_enter ;;
		5) clear; cronjob         ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
