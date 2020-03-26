#!/usr/bin/env bash

# Full upgrade of the system
sudo apt-get update && apt-get upgrade

# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

# Install tools for networking
sudo apt-get -y install dialog debconf-utils apt-utils iputils-ping iptables iputils-tracepath traceroute netcat

# Install iptables-persistent
sudo echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
sudo echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y iptables-persistent

# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute curl git-core bzip2 wget

# If binaries (package) of nebula is not present, download it
if [ -n "$(ls -A /vagrant/nebula-linux-amd64.tar.gz 2>/dev/null)" ]
then
  wget -P /vagrant https://github.com/slackhq/nebula/releases/download/v1.1.0/nebula-linux-amd64.tar.gz
fi

# Create the directory for mounting the VirtualBox Guest Additions
# sudo mkdir /tmp/mount
# sudo chmod 777 /tmp/mount
