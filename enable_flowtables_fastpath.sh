#!/bin/sh
# See: https://thermalcircle.de/doku.php?id=blog:linux:flowtables_1_a_netfilter_nftables_fastpath

nft add table inet filter
nft add flowtable inet filter f \
   { hook ingress priority 0\; devices = { br-lan, eth2 }\; }
nft add chain inet filter forward { type filter hook forward priority 0\; }
nft add rule inet filter forward meta l4proto tcp flow add @f
