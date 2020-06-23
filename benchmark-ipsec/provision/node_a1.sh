#!/usr/bin/env bash

#sudo /vagrant/files/nebula -config /vagrant/config/node-a1/config.yml &

# We generate files with random content.
# head -c 1M    < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/01_origin_file_0001M.dat
# head -c 10M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/02_origin_file_0010M.dat
# head -c 50M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/03_origin_file_0050M.dat
# head -c 100M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/04_origin_file_0100M.dat
# head -c 500M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/05_origin_file_0500M.dat
# head -c 1000M < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/06_origin_file_1000M.dat

# We generate key-pair for scp or rsync without passphrase
# ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# Manually run this
# ssh-copy-id -i id_rsa.pub vagrant@192.200.1.100


cp /vagrant/config/pki/server-root-ca.pem   /etc/ipsec.d/cacerts/
cp /vagrant/config/pki/node-a1-key.pem      /etc/ipsec.d/private/
cp /vagrant/config/pki/node-a1-cert.pem     /etc/ipsec.d/certs/
cp /vagrant/config/pki/lighthouse1-cert.pem /etc/ipsec.d/certs/

cat >/etc/ipsec.conf <<EOL
config setup
    charondebug="all"
    uniqueids=no
    strictcrlpolicy=no

conn node-a1-to-lighthouse1
    forceencaps=yes
    auto=route
    closeaction=hold
    dpdaction=hold
    keyexchange=ikev2
    left=%any
    leftsourceip=172.20.1.100/24    
    leftcert=/etc/ipsec.d/certs/lighthouse1-cert.pem
    #auto=start
    right=172.18.18.18
    rightsubnet=10.40.40.0/24
    rightid="C=FI, O=VPN Client A, CN=172.16.16.16"

EOL

cat >/etc/ipsec.secrets <<EOL
172.40.40.5 : RSA "/etc/ipsec.d/private/node-a1-key.pem"
EOL