sudo apt-get update
sudo apt-get -y install iputils-ping iptables

## NAT traffic going out of the gateways
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
