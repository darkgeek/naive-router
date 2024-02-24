#!/bin/bash

BRIDGE_DEV="br-lan"
LAN_DEVS=("eth0" "eth1")

function create {
    ip link add name $BRIDGE_DEV type bridge
    ip link set dev $BRIDGE_DEV up

    for device in "${LAN_DEVS[@]}"
    do
        ip link set dev $device up
        ip link set $device master $BRIDGE_DEV
        echo Add device to bridge $BRIDGE_DEV: $device
    done
    
    echo Show devices in the bridge $BRIDGE_DEV:
    bridge link
}

function destory {
    for device in "${LAN_DEVS[@]}"
    do
        ip link set $device nomaster
        ip link set $device down
        echo Remove device from bridge $BRIDGE_DEV: $device
    done

    ip link delete $BRIDGE_DEV type bridge

    echo Show devices in the bridge $BRIDGE_DEV:
    bridge link
}

function print_help {
    echo "Usage: config_bridge.sh -a [create|destory]"
}

getopts "a:" OPTION
case "$OPTION" in
    a)
        action=$OPTARG
        [[ $action = "create" ]] && create && exit $?
        [[ $action = "destory" ]] && destory && exit $?

        echo Incorrect action
        print_help
        ;;
    *)
        echo Incorrect options provided
        print_help
        ;;
esac
