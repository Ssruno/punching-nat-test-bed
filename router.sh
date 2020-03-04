#!/usr/bin/env bash

# How to see NAT table with line numbers
# sudo iptables -t nat -L --line-numbers -n

# How to see NAT table with counters
# sudo iptables -t nat -L -n -v

## NAT traffic going out of the gateways
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
