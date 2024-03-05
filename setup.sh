#!/bin/sh

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

echo Step 1: init bridge
$CURRENT_DIR/config_bridge.sh -a create

echo Step 2: Setting up flowtables fastpath
$CURRENT_DIR/enable_flowtables_fastpath.sh
