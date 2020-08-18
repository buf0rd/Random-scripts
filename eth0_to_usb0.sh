#!/bin/bash

ifconfig eth0 down
iptables -f
# Enable IPv4 and IPv6 forwarding (feature):
sudo sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.default.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1

# Assign IP address to eth0:
ip link set up dev eth0
ip addr add 10.43.0.1/24 dev eth0

# Packets forwarding usb0 -- eth0:
iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o usb0 -j ACCEPT


echo 'nameserver 9.9.9.9' >> /etc/resolv.conf

