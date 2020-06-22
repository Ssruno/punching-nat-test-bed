#!/usr/bin/env bash

# If binaries (package) of nebula is not present, download it
# if [ ! -f "/vagrant/nebula-linux-amd64.tar.gz" ]
# then
#   wget -P /vagrant https://github.com/slackhq/nebula/releases/download/v1.2.0/nebula-linux-amd64.tar.gz
# fi

# Delete certificates, binaries, etc from previous Nebula deployment
# if [ -n "$(ls -A /vagrant/files/ 2>/dev/null)" ]
# then
#   rm -rf /vagrant/files/*.key
#   rm -rf /vagrant/files/*.crt
#   rm -rf /vagrant/files/nebula
#   rm -rf /vagrant/files/nebula-cert
# fi

# tar -xvf /vagrant/nebula-linux-amd64.tar.gz -C /vagrant/files
# cd /vagrant/files/
# /vagrant/files/nebula-cert ca -name "Andromeda Galaxy, Inc"

# /vagrant/files/nebula-cert sign -name "lighthouse1" -ip "192.200.1.100/24"
# /vagrant/files/nebula-cert sign -name "node-a1"     -ip "192.200.1.5/24" 

# We generate key-pair for scp or rsync without passphrase
# ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""