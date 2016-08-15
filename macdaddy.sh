#!/bin/bash
echo "Bringing down the interfaceasses"
ifconfig wlan1 down && ifconfig wlan0 down
echo "Spoofing mac to known ALLOWED mac on wifi AP"
macchanger --mac 11:22:33:44:55:67 wlan1 && macchanger --mac 11:22:33:44:55:66 wlan0
echo "Bringing up those faces I told u about"

## a lil something extra i guess for kali / parrotos
iw reg set GY
#
ifconfig wlan1 up && ifconfig wlan0 up

print iwconfig
exit 0
