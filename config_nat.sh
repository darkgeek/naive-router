#!/bin/sh

LAN_DEV="br-lan"
WAN_DEV="eth2"

nft add table inet nat
nft add chain inet nat postrouting '{ type nat hook postrouting priority 100 ; }'

nft add rule inet nat postrouting oifname $WAN_DEV masquerade
nft add rule inet filter forward ct state related,established accept
nft add rule inet filter forward iifname $LAN_DEV oifname $WAN_DEV accept

