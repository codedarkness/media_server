# Media Server

Setup for a headless server for debian-based systems. This script was tested in a full working debian buster server.

Firts you need to install a base system of **Debian 10** in this case i used [this iso](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/10.4.0+nonfree/amd64/iso-cd/firmware-10.4.0-amd64-netinst.iso) for non-free firmware, i'm using a mimi pc and has a built in wifi. Not the best speed but works fine. Other wise you can use [this iso](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.4.0-amd64-netinst.iso). After the install, make sure that the ssh server is running and install git.

That's it you're ready to go!

## What this does

* Install Torrent
	* Transmission
	* Trnasmission-remote-cli
	* Setup Transmission
* Install Plex Media Server
* Install Samba
	* Setup Samba share
* Install wpa-supplicant (not necessary for non-free drivers)
	* Setup wifi network
* Setup a static ip address
* Install openVPN
	* Setup openvpn with private internet access
	* Setup openvpn with NordVPN (sonner)

Tested and full running in **Debian 10 (Buster)** it should work in **Ubuntu Server** as well.
Also tested in a **Raspberry Pi 4** it should work whit **Raspberry Pi 3** as  well.
