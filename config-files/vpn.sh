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
#        FILE: vpn.sh
#       USAGE: ./vpn.sh | sub menu of media_server.sh
#
# DESCRIPTION: install con configure a vpn in your debian-based
#              server
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
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

	echo " Copy new file"
	sudo cp -i config-files/txt/openvpnauto /etc/init.d/ &&
	sudo chmod +x /etc/init.d/openvpnauto &&
	echo " New file has been copied" || echo " Upsss!"
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

	echo " Changing login.txt permission to 700"
	sudo chmod 700 /etc/openvpn/pass.txt &&
	echo " Permissions has been changed" || echo " Why we use Linux"
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
	echo " Write the name of the server you like, but without extension"
	echo " and write it with capitals and blank spaces, like this:"
	echo " US New York City or CA Montrial"
	echo ""

	echo " Testing ip address"
	wget http://ipinfo.io/ip -qO - &&
	echo " Everything looks good?"
	echo ""

	read -p " vpn server to use : " choice;
	sudo sed -i "s+/etc/openvpn/.*.ovpn+/etc/openvpn/$choice.ovpn+g" /etc/init.d/openvpnauto &&
	sudo update-rc.d openvpnauto defaults 98 &&
	sudo service openvpnauto start &&
	echo " the vpn server has been setup" || echo "Huston we have a problem!"
	echo ""

	echo " Testing ip address"
	wget http://ipinfo.io/ip -qO - &&
	echo " Everything looks good?"
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
