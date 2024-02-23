#!/bin/sh

LAN_DEV="br-lan"
LAN_V4_ADDRESS="192.168.6.1/24"
LAN_V6_ADDRESS="fd3c:baba:d4ca:0fea::1/64"

ip -4 address add dev $LAN_DEV $LAN_V4_ADDRESS 
ip -6 address add dev $LAN_DEV $LAN_V6_ADDRESS
ip addr show dev $LAN_DEV
