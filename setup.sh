#!/bin/sh

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

echo Step 1: init bridge
$CURRENT_DIR/config_bridge.sh -a create

echo Step 2: assign ip address to lan
$CURRENT_DIR/config_lan_address.sh

echo Step 3: create NAT
$CURRENT_DIR/config_nat.sh
