sudo apt-get update
sudo apt-get install iputils-ping iptables

## NAT traffic going out of the gateways
sudo iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
