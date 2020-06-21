#!/usr/bin/env bash

# Enable ipv4 forwarding
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf

# Install tools for networking
sudo apt-get -y install dialog debconf-utils apt-utils iputils-ping iptables iputils-tracepath traceroute netcat conntrack nmap wget rsync

# Install iptables-persistent
sudo echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
sudo echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y iptables-persistent

# Install libs
sudo apt-get install -y net-tools locate vim nano tcpdump dnsutils traceroute curl git-core bzip2

# Create the directory for mounting the VirtualBox Guest Additions
# sudo mkdir /tmp/mount
# sudo chmod 777 /tmp/mount

# We add timestamp and git branch to the shell
echo "parse_git_branch() {
             git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\033[1;33m(\t)\033[m \033[1;36m[ \u |\033[m \033[1;32m\W\033[m \033[1;36m]\033[m $(parse_git_branch)\n> '
" | tee -a /root/.bashrc /home/vagrant/.bashrc
