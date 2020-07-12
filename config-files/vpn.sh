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
	echo " Getting ready to setup Private Internet Access"
	sleep 1;

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

	echo " Creating a pass.txt file"
	echo " add usarname (line 1) password (line 2)"
	sleep 2;
	sudo vim /etc/openvpn/pass.txt

	(cd /etc/openvpn/ && ls *.ovpn)
	sleep 2;

	read -p " vpn server to user (type the name like it is without extention) : " choise;
	sudo sed -i 's/auto-user-pass/auto-user-pass /etc/openvpn/pass.txt/g' /etc/openvpn/'$choice'.ovpn &&
	sudo sed -i 's/vpn_server.ovpn/'$choice'.ovpn/g' /usr/local/bin/ovpnstart.sh &&
	echo " username and password where added" || echo "Huston we have a problem!"
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

	sleep 3;
	sudo crontab -e

	echo " You're Done!"
	echo " Now reboot your server/computer and check if everything works as spected"
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
	echo " 2 - Setup PIA"
	echo " 3 - Name/Options"
	echo " 4 - Name/Options"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install_openvpn ; press_enter ;;
		2) clear; setup_pia       ; press_enter ;;
		3) clear; Name/Options ; press_enter ;;
		4) clear; Name/Options ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
