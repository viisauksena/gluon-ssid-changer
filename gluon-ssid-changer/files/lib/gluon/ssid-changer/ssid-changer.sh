#!/bin/sh

# maximum simplyfied, no more ttvn rating
check=$(batctl gwl -H|grep -v "gateways in range"|wc -l)
name=$(uci get system.@system[0].hostname|tail -c 21)
offline="FF_OFFLINE_"
default="freiburg.freifunk.net"
offi=$offline$name

if [ $check -eq 0 ] ; then
        if [ "$(uci get wireless.client_radio0.ssid)" == "$offi" ] ; then echo "$0 - still on $offi" ; exit 0 ; fi
        echo "$0 change ssid to $offi" | logger
        uci set wireless.client_radio0.ssid="$offi"
        sed -i s/^ssid=$default/ssid=$offi/ /var/run/hostapd-phy0.conf
        killall -HUP hostapd
fi
if [ $check -gt 0 ] ; then
        if [ "$(uci get wireless.client_radio0.ssid)" == "$default" ] ; then echo "$0 - still on $default" ; exit 0 ; fi
        echo "$0 change ssid to $default"| logger
        uci set wireless.client_radio0.ssid="$default"
	sed -i s/^ssid=$offi/ssid=$default/ /var/run/hostapd-phy0.conf
        killall -HUP hostapd
fi
