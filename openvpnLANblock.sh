#!/bin/bash

iptables -I FORWARD -s 10.1.0.0/24 -d 192.168.1.0/24 -j DROP​
#iptables -A PREROUTING -s 10.8.0.0/24 -d 192.168.1.0/24 -j REJECT

exit 0
