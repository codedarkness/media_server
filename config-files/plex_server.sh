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
#        FILE: plex_server.sh
#       USAGE: ./plex_server.sh | sub menu of torrent_box.sh
#
# DESCRIPTION: install plex media server for a headless server
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 06-25-20 9:03
#
# -----------------------------------------------------------------

plex_server() {
	echo ""
	echo " Plex Media Server"
	sleep 2;
	echo " Importing repository's GPG Key"

	echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list &&
	curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
	echo ""

	echo " Update Repositories"
	sudo apt update
	echo ""

	echo " Installing Plex"
	sudo apt install plexmediaserver
	echo ""

	echo " Checking plex status"
	sudo systemctl status plexmediaserver
	echo ""

	IP=$(hostname -I)
	echo " Test your new plex server; open the web browser and type https://$IP:32400/web"
}

open_plex() {
	IP=$(hostname -I)
	xdg-open https://$IP:32400/web
}

readme() {

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
	echo "  _____  _            _____                          "
	echo " |  __ \| |          / ____|                         "
	echo " | |__) | | _____  _| (___   ___ _ ____   _____ _ __ "
	echo " |  ___/| |/ _ \ \/ /\___ \ / _ \ '__\ \ / / _ \ '__|"
	echo " | |    | |  __/>  < ____) |  __/ |   \ V /  __/ |   "
	echo " |_|    |_|\___/_/\_\_____/ \___|_|    \_/ \___|_|   "
	echo ""
	echo " Install Plex Media Server in Debian-Based Systems"
	echo ""
	echo " 1 - Install Plex Server"
	echo " 2 - Open Plex (web browser)"
	echo " 3 - Name/Options"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; plex_server ; press_enter ;;
		2) clear; open_plex   ; press_enter ;;
		3) clear; readme      ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
