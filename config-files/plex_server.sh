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

	echo deb https://downloads.plex.tv/repo/deb/ public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list &&
	echo " GPG Key has imported" || echo " We have a problem in the matrix!"
	echo ""

	wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add - &&
	#curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add - &&
	echo " Plex Key has been added" || echo " Did you broke something"
	echo ""

	echo " Update Repositories"
	sudo apt update
	echo ""

	echo " Installing Plex"
	sudo apt install plexmediaserver
	echo ""

	echo " Checking plex status"
	sudo systemctl --no-pager status plexmediaserver
	echo ""

	IP=$(hostname -I)
	echo " Test your new plex server; open the web browser and type https://$IP:32400/web"
}

plex_server_deb() {
	echo ""
	echo " Download and Installing Plex (.deb)"
	sleep 2;
	echo ""

	echo " Download deb pakage"
	wget https://downloads.plex.tv/plex-media-server-new/1.19.4.2935-79e214ead/debian/plexmediaserver_1.19.4.2935-79e214ead_amd64.deb &&
	echo " Download Done" || echo " Houston we have a problem!"
	echo ""

	echo " Installing Plex (.deb)"
	sudo dpkg -i plexmediaserver_1.19.4.2935-79e214ead_amd64.deb &&
	echo " Installation complete" || echo " Did you brake something!"

	echo " Checking source list"
	dpkg -L plexmediaserver &&
	echo " Source list is present" || echo " Uppsss"
	echo ""

	while true; do
		read -p " Edit plexmediaserver.list [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo vim /etc/apt/sources.list.d/plexmediaserver.list; exit ;;
			[Nn]* )
				funcion ; exit ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo " Adding Plex Key"
	wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add - &&
	echo " Plex Key has been added" || echo " Did you brake something"
	echo ""

	sudo apt update &&
	echo " Everything looks good" || echo " Upsssss!"

	echo " Checking plex status"
	sudo systemctl --no-pager status plexmediaserver
	echo ""

	IP=$(hostname -I)
	echo " Test your new plex server; open the web browser and type https://$IP:32400/web"
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
	echo " 2 - Install Plex Server .deb"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; plex_server     ; press_enter ;;
		2) clear; plex_server_deb ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
