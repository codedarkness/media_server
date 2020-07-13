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
	sudo apt install -y transmission-cli transmission-common transmission-daemon transmission-remote-cli &&
	echo " Installations Done" || echo " Holly... something happend"
	echo ""
}

setup_transmission() {
	echo ""
	echo " Setup Transmission with username and password"
	echo ""
	echo " Follow the instructios to setup your transmission"
	sleep 1;

	echo " Stopting Transmission-daemon"
	sudo service transmission-daemon stop;
	echo ""

	read -p " Transmission user-name : " choice;
	sudo sed -i 's/"rpc-username": ".*"/"rpc-username": "'$choice'"/g' /etc/transmission-daemon/settings.json &&
	echo " The user name has been added" || echo " Did you broke somthing!"
	echo ""

	read -p " Transmission password : " choice;
	sudo sed -i 's/"rpc-password": ".*"/"rpc-password": "'$choice'"/g' /etc/transmission-daemon/settings.json &&
	echo " Password has ben setup" || echo " Something whent wrong!"
	echo ""

	while true; do
		read -p " Authenticacion is setup to true (defaul) do you like to disable [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo sed -i 's/"rpc-authentication-required": true,/"rpc-authentication-required": false,/g' /etc/transmission-daemon/settings.json &&
				echo " Autentication has been disable" || echo " Holy... Something is broken!"; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	read -p " Full path for downloads : " choice;
	sudo sed -i 's+"download-dir": ".*"+"download-dir": "'$choice'"+g' /etc/transmission-daemon/settings.json &&
	echo " Download dir has been changed" || echo " Something whent wrong!"
	echo ""

	read -p " Full path for incomplete downloads : " choice;
	sudo sed -i 's+"incomplete-dir": ".*"+"incomplete-dir": "'$choice'"+g' /etc/transmission-daemon/settings.json &&
	echo " Incompre downloads has been changed" || echo " Something whent wrong!"
	echo ""

	sudo sed -i 's/"incomplete-dir-enabled": false/"incomplete-dir-enabled": true/g' /etc/transmission-daemon/settings.json &&
	echo " The path has been setup" || echo " Upsss!"
	echo ""

	read -p " Allow IP address to connect to transmission (192.168.*.*) : " choice;
	sudo sed -i 's/"rpc-whitelist": ".*"/"rpc-whitelist": "127.0.0.1,'$choice'"/g' /etc/transmission-daemon/settings.json &&
	echo " IP address has been setup" || echo " Huston we have a problem!"

	sudo sed -i 's/"umask": .*/"umask": 2,/g' /etc/transmission-daemon/settings.json &&
	echo " umas was setup to parameter 2" || echo " We have a glitch in the matrix"
	echo ""

	read -p " Server user name : " choice;
	sudo usermod -a -G debian-transmission $choice &&
	echo " The user $choice has been added to debian-transmission group" || echo " We have a problem"
	echo ""

	sudo service transmission-daemon start &&
	echo " Transmission has been setup!"
	echo ""

	sudo systemctl --no-pager status transmission-daemon
	echo ""

	IP=$(hostname -I)
	echo " Test transmission in you web borwser http://$IP:9091"
	echo ""
}

setup_manually() {
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
	sleep 1;
	echo ""
	while true; do
		read -p " Edit transmission settings.json [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo service transmission-daemon stop;
				sudo vim /etc/transmission-daemon/settings.json ;
				sudo service transmission-daemon start; break ;;
			[Nn]* )
				echo " Bye!!" ; break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	sudo systemctl --no-pager status transmission-daemon
	echo ""
}

enable_authentication() {
	echo ""
	echo " Setup Transmission Authentication"
	echo ""
	echo " It authentication was desable, you can enabled here "
	sleep 1;

	while true; do
		read -p " Enabled Authenticacion [y - n] : " yn
		case $yn in
			[Yy]* )
				echo " Stopting Transmission-daemon"
				sudo service transmission-daemon stop;
				echo ""

				sudo sed -i 's/"rpc-authentication-required": .*,/"rpc-authentication-required": true,/g' /etc/transmission-daemon/settings.json &&
				echo " Autentication has been enabled" || echo " Holy... Something is broken!"

				sudo service transmission-daemon start &&
				echo " Transmission has been setup!" || echo " Problems are part of life"
				echo ""; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	sudo systemctl --no-pager status transmission-daemon
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
	echo " 2 - Setup (username, password, path for downloads)"
	echo " 3 - Setup (manually)"
	echo " 4 - Enable authentication (password)"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install_transmission ; press_enter ;;
		2) clear; setup_transmission   ; press_enter ;;
		3) clear; setup_manually       ; press_enter ;;
		4) clear; enable_authentication ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
