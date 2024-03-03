#!/bin/sh

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

echo Step 1: init bridge
$CURRENT_DIR/config_bridge.sh -a create

echo Step 2: create NAT
$CURRENT_DIR/config_nat.sh

echo Step 3: Setting up flowtables fastpath
$CURRENT_DIR/enable_flowtables_fastpath.sh
