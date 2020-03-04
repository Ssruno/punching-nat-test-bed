sudo apt-get update && apt-get upgrade


# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

sudo apt-get -y install dialog debconf-utils apt-utils iputils-ping iptables iputils-tracepath traceroute

# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute curl git-core
# Install iptables-persistent to persist the changes
sudo echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
sudo echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y iptables-persistent


## NAT traffic going out of the gateways
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain

sudo iptables --table nat --append POSTROUTING --out-interface eth2 -j MASQUERADE
sudo iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
#sudo iptables --append FORWARD --in-interface eth1 -j ACCEPT

## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
