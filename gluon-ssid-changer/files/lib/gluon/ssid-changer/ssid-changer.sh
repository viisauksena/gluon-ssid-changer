#!/bin/sh

# maximum simplyfied, no more ttvn rating
check=$(batctl gwl -H|grep -v "No gateways in range"|wc -l)
name=$(uci get system.@system[0].hostname)
offline="FF_OFFLINE_"
default="freiburg.freifunk.net"
hostapdconf=/var/run/hostapd-phy0.conf

ssid=$default
if [ $check -eq 0 ] ; then
        ssid=$offline$name;
fi

if [ "$(uci get wireless.client_radio0.ssid)" == "$ssid" ] && [ "$(grep ^ssid=.* $hostapdconf|cut -d= -f2)" == "$ssid" ] ; then 
        echo "$0 - still on $ssid" | logger
        exit 0;
fi

echo "$0 change ssid to $ssid" | logger
uci set wireless.client_radio0.ssid="$ssid"
sed -i s/^ssid=.*/ssid=$ssid/ $hostapdconf
killall -HUP hostapd
