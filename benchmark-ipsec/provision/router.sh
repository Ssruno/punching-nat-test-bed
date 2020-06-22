#!/usr/bin/env bash

# How to see NAT table with line numbers
# sudo iptables -t nat -L --line-numbers -n

# How to see NAT table with counters
# sudo iptables -t nat -L -n -v

## NAT traffic going out of the gateways
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain

sudo iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 192.168.111.15

## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6

# We add some delay on the interfaces towards site A and site B, to have the sum of 500ms in total. 
# Without this delay, there is some port reallocation happening with the NAT when the hole punch takes place.
# Reference: https://netbeez.net/blog/how-to-use-the-linux-traffic-control/
#sudo tc qdisc add dev eth1 root netem delay 250ms
#sudo tc qdisc add dev eth2 root netem delay 250ms
# To delete the delay:
# sudo tc qdisc del dev eth1 root
# sudo tc qdisc del dev eth2 root
# To check the active rules:
# sudo tc qdisc show  dev eth1
# sudo tc qdisc show  dev eth2
