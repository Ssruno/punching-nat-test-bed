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

cp /vagrant/config/pki/server-root-ca.pem   /etc/ipsec.d/cacerts/
cp /vagrant/config/pki/lighthouse1-key.pem  /etc/ipsec.d/private/
cp /vagrant/config/pki/lighthouse1-cert.pem /etc/ipsec.d/certs/
cp /vagrant/config/pki/node-a1-cert.pem     /etc/ipsec.d/certs/

sudo ufw allow 500,4500/udp

sudo iptables -t nat -A POSTROUTING -s 10.40.40.0/24 -o eth1 -m policy --dir out --pol ipsec -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 10.40.40.0/24 -o eth1 -j MASQUERADE

cat >/etc/ipsec.conf <<EOL
config setup
    charondebug="all"    
    strictcrlpolicy=no
    uniqueids=yes

conn lighthouse1-to-node-a1
    type=tunnel
    forceencaps=yes
    auto=start
    #closeaction=hold
    dpdaction=clear
    keyexchange=ikev2

    left=172.20.1.100
    leftid="C=FI, O=VPN lighthouse1, CN=172.20.1.100"
    leftcert=/etc/ipsec.d/certs/lighthouse1-cert.pem
    leftsubnet=0.0.0.0/0
    leftsendcert=always

    right=%any
    rightid="C=FI, O=VPN node-a1, CN=10.40.40.5"
    rightsourceip=10.40.40.5

EOL


cat >/etc/ipsec.secrets <<EOL
172.20.1.100 : RSA "/etc/ipsec.d/private/lighthouse1-key.pem"
EOL

sudo ipsec restart
