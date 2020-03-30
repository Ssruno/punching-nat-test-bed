#!/usr/bin/env bash

# If binaries (package) of nebula is not present, download it
if [ ! -f "/vagrant/nebula-linux-amd64.tar.gz" ]
then
  wget -P /vagrant https://github.com/slackhq/nebula/releases/download/v1.1.0/nebula-linux-amd64.tar.gz
fi

# Delete certificates, binaries, etc from previous Nebula deployment
if [ -n "$(ls -A /vagrant/files/ 2>/dev/null)" ]
then
  rm -rf /vagrant/files/*
fi

tar -xvf /vagrant/nebula-linux-amd64.tar.gz -C /vagrant/files
cd /vagrant/files/
/vagrant/files/nebula-cert ca -name "Andromeda Galaxy, Inc"

/vagrant/files/nebula-cert sign -name "lighthouse1" -ip "192.200.1.100/24"
/vagrant/files/nebula-cert sign -name "node-a1"     -ip "192.200.1.5/24" 
/vagrant/files/nebula-cert sign -name "node-a2"     -ip "192.200.1.6/24" 
/vagrant/files/nebula-cert sign -name "node-b1"     -ip "192.200.1.7/24"
/vagrant/files/nebula-cert sign -name "node-b2"     -ip "192.200.1.8/24"
/vagrant/files/nebula-cert sign -name "node-f1"     -ip "192.200.1.9/24"

#sudo /vagrant/files/nebula -config /vagrant/config/lighthouse1/config.yml &
