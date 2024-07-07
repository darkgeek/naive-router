# naive-router

Let's turn our Linux box into an ipv6 ready router!

## Prerequisite 
* `dhcpcd`: get ip for WAN port, ipv6-pd...
* `dnsmasq`: dhcp server, local net dns resolution
* `nftables`: you need a firewall to secure your home!

On Debian, install them via:
```shell
sudo apt install dhcpcd dnsmasq nftables
```

## How to deploy
> No matter how many LAN ethernet ports are on your Linux box, a bridge is created to combine all these LAN ports, to ease the management.

In this repo's default configurations, `eth0` and `eth1` are LAN ports, `eth2` is WAN port. But this might not fit your needs. You should know which ethernet port is your WAN port, which are LAN ports. Then, change the device names in all the configuration files respectively.

After your customizations are done, copy the files where they should be.

Finally, ensure there aren't any other dhcp client running, or there might be some race conditions. In Debian, it's needed to comment on all the ethernet device entries in `/etc/network/interfaces`, and disable the ifupdown service by `sudo systemctl disable networking.service`.
