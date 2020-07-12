#!/bin/bash -X
clear
cd /etc/openvpn/
/usr/sbin/openvpn --config '/etc/openvpn/vpn_server.ovpn' --daemon
cd /
