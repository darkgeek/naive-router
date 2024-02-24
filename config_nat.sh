#!/bin/sh

LAN_DEV="br-lan"
WAN_DEV="eth2"

iptables -t nat -A POSTROUTING -o $WAN_DEV -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $LAN_DEV -o $WAN_DEV -j ACCEPT
