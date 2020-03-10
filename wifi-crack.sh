#!/bin/bash

clear
compatible=0
iface="$1"
channel=$2
frequency=$3
ifaces=$(ifconfig -a | sed 's/[: \t].*//;/^\(lo\|\)$/d')

if [ "$iface" == "" ] ; then
    iface="wlan0"
fi
while IFS= read -r line; do
    if [ "$iface" == "$line" ] ; then
        compatible=1
    fi
done <<< "$ifaces"

if [ $compatible -eq 1 ] ; then

    airmon-ng check kill >/dev/null
    airmon-ng stop $iface >/dev/null #>/dev/null

    if [ $? -eq 1 ] ; then # if stop failed - start monitor mode
        airmon-ng start $iface >/dev/null
        if [ $? -eq 0 ] ; then 
            echo "Monitor mode enabled"
	    #wireshark -Iki $iface &
	    #besside-ng $iface
        fi
    else
        echo "Monitor mode disabled"
	#pkill -f "wireshark"
	service network-manager restart
    fi

    airmon-ng check wlan0 >/dev/null
else
    echo "$iface is not a valid interface, try:"
    echo "$ifaces"
fi

exit
