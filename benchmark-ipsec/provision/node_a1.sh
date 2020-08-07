#!/usr/bin/env bash

#sudo /vagrant/files/nebula -config /vagrant/config/node-a1/config.yml &

# We generate key-pair for scp or rsync without passphrase
# ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# Manually run this
# ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@172.20.1.100


cp /vagrant/config/pki/server-root-ca.pem   /etc/ipsec.d/cacerts/
cp /vagrant/config/pki/node-a1-key.pem      /etc/ipsec.d/private/
cp /vagrant/config/pki/node-a1-cert.pem     /etc/ipsec.d/certs/
cp /vagrant/config/pki/lighthouse1-cert.pem /etc/ipsec.d/certs/

# To make it similar to nebula
# sudo ifconfig eth1 mtu 1300
# sudo ifconfig eth1 txqueuelen 500
# sudo route add default gw 10.40.40.40 eth1

cat >/etc/ipsec.conf <<EOL
config setup
    charondebug="all"    
    strictcrlpolicy=no
    uniqueids=yes

conn node-a1-to-lighthouse1
    type=tunnel
    forceencaps=yes
    auto=start    
    dpdaction=clear
    keyexchange=ikev2

    ike=aes256gcm128-sha256-curve25519!
    esp=aes256gcm128-sha256-curve25519!

    right=172.20.1.100    
    rightid="C=FI, O=VPN lighthouse1, CN=172.20.1.100"
    rightsubnet=172.20.1.0/24
    rightcert=/etc/ipsec.d/certs/lighthouse1-cert.pem

    leftsourceip=%config    
    leftid="C=FI, O=VPN node-a1, CN=10.40.40.5"
    leftcert=/etc/ipsec.d/certs/node-a1-cert.pem

EOL

cat >/etc/ipsec.secrets <<EOL
10.40.40.5 : RSA "/etc/ipsec.d/private/node-a1-key.pem"
EOL

sudo apt-get install -y iperf3 rsync

#sudo ipsec restart
