#!/bin/sh -x
clear
cd /
extip=$(curl ifconfig.me) #this finds your external ip address
if [ $extip = "my.actual.external.ip" ]; then
/usr/local/bin/ostart.sh | echo "restarting openvpn"
else
 echo "vpn is working"
fi
exit 0
