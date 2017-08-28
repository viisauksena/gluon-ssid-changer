ssid-changer.sh
===============

This script changes the SSID when there is no connection to the selected Gateway.

Once a minute it checks if there is a gateway reacheable with `batctl gwl -H` and
decides if a change of the SSID is necessary.

*It is a simplified rewrite of https://github.com/ffac/gluon-ssid-changer that doesn't check
the tx value any more. It is in use in Freifunk Freiburg*

*if you want a more advanced script, or are in need of 2.4G AND 5G than try the aachen script or the rewrite from Freifunk Nord https://github.com/Freifunk-Nord/gluon-ssid-changer/*

Gluon versions
==============
This branch of the skript contains the the ssid-changer version for the gluon 2017.1.x
based on lede `lede`. There is also a pre 2016.1 (OpenWrt based)
version in the branch `chaos-calmer`. It will probably not work in 2017.1.++ .

Implement this package in your firmware
=======================================
Create a file "modules" with the following content in your
<a href="https://github.com/ffac/site/tree/offline-ssid"> site directory:</a>

GLUON_SITE_FEEDS="ssidchanger"<br>
PACKAGES_SSIDCHANGER_REPO=https://github.com/viisauksena/gluon-ssid-changer.git<br>
PACKAGES_SSIDCHANGER_COMMIT=c6640854ccf07c0e9c9e8d47f11bd55a34237ac7<br>
PACKAGES_SSIDCHANGER_BRANCH=lede<br>

With this done you can add the package gluon-ssid-changer to your site.mk
