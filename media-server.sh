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
#        FILE: media-server.sh
#       USAGE: ./media-server.sh
#
# DESCRIPTION: setup a torrent box and plex server for raspberry pi
#	       and debian systems
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-24-20 4:00
#
# -----------------------------------------------------------------

torrent_server() {
	config-files/torrent_server.sh
}

plex_server() {
	config-files/plex_server.sh
}

vpn() {
	config-files/vpn.sh
}

first_install() {
	config-files/configs.sh
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
	echo "  __  __          _ _        _____                          "
	echo " |  \/  |        | (_)      / ____|                         "
	echo " | \  / | ___  __| |_  __ _| (___   ___ _ ____   _____ _ __ "
	echo " | |\/| |/ _ \/ _' | |/ _' |\___ \ / _ \ '__\ \ / / _ \ '__|"
	echo " | |  | |  __/ (_| | | (_| |____) |  __/ |   \ V /  __/ |   "
	echo " |_|  |_|\___|\__,_|_|\__,_|_____/ \___|_|    \_/ \___|_|	  "
	echo ""
	echo " Torrent box whit transmission and Plex Media server"
	echo " For a headless media server (Raspberry Pi / Debian"
	echo ""
	echo " 1 - Torrent Box"
	echo " 2 - Plex Media Server"
	echo " 3 - VPN"
	echo " 4 - Torrent Remote (local machine)"
	echo " 5 - First Install (for new server installation)"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; torrent_server  ;;
		2) clear; plex_server     ;;
		3) clear; vpn             ;;
		4) clear; torren_remote   ;;
		5) clear; first_install   ;;
		6) clear; server_configs  ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
