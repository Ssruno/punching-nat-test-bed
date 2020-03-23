#!/usr/bin/env bash

tar -xvf /vagrant/nebula/nebula-linux-amd64.tar.gz -C /vagrant/nebula/files
cd /vagrant/nebula/files/
/vagrant/nebula/files/nebula-cert ca -name "Andromeda Galaxy, Inc"

/vagrant/nebula/files/nebula-cert sign -name "lighthouse1" -ip "192.200.1.100/24"
/vagrant/nebula/files/nebula-cert sign -name "node-a1"     -ip "192.200.1.4/24" 
/vagrant/nebula/files/nebula-cert sign -name "node-a2"     -ip "192.200.1.9/24" 
/vagrant/nebula/files/nebula-cert sign -name "node-b1"     -ip "192.200.1.13/24"

sudo /vagrant/nebula/files/nebula -config /vagrant/nebula/config/lighthouse1/config.yml &
