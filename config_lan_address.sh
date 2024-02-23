#!/bin/sh

LAN_DEV="br-lan"
LAN_V4_ADDRESS="192.168.6.1/24"

ip -4 address add dev $LAN_DEV $LAN_V4_ADDRESS 
