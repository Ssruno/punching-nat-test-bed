sudo apt-get update && apt-get upgrade

# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

sudo apt-get -y install dialog debconf-utils apt-utils iputils-ping iptables iputils-tracepath traceroute

# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute curl git-core
# Install iptables-persistent
sudo echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
sudo echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y iptables-persistent


## NAT traffic going out of the gateways
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


## Save the rules
sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6
