#!/bin/bash

STATE_FILE_PATH=/tmp/wan-last-ipv6-address
WAN_IF="eth2"
LAN_IF="br-lan"

remove_old_delegated() {
    ip -6 addr show dev br-lan scope global dynamic | awk '/inet6/{print $2}' | while read -r address; do
    ip addr del "$address" dev "$LAN_IF" && echo "Deleted old delegated ipv6 address: $address"
done
}

restart_dhcpcd() {
    systemctl restart dhcpcd && echo "Restart dhcpcd done."
}

# Start monitor on wan event
ip -6 monitor address dev $WAN_IF |  while read -r line; do
    # check if ipv6 changes
    if echo "$line" | grep -q 'inet6'; then
        # extract ipv6 (like inet6 2001:db8::1/64)
        addr_part=$(echo "$line" | awk '{for(i=1; i<=NF; i++) { if ($i == "inet6") { print $(i+1); exit } } }')
        [ -z "$addr_part" ] && continue  
        
        # exclude fe80 address
        addr="$addr_part"
        if [[ ! "$addr" =~ ^fe80 ]]; then
            current_ipv6=$(ip a show dev $WAN_IF scope global | awk '/inet6/{print $2}' | awk 'NR==1')
            if [ -f $STATE_FILE_PATH ]; then
                last_ipv6=$(cat $STATE_FILE_PATH)
                if [ -n "$last_ipv6" ] && [ -n "$current_ipv6" ] && [ "$last_ipv6" != "$current_ipv6" ]; then
                    echo "ipv6 address of $WAN_IF has changed, before=$last_ipv6, now=$current_ipv6"
                    remove_old_delegated
                    restart_dhcpcd
                fi
            fi

            if [ -n "$current_ipv6" ]; then
                echo -n "$current_ipv6" > $STATE_FILE_PATH
            fi
        fi
    fi
done
