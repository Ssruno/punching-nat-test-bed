#!/usr/bin/env bash


# We generate key-pair for scp or rsync without passphrase
# ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# Copy certificates
cp /vagrant/config/pki/server-root-ca.pem   /etc/ipsec.d/cacerts/
cp /vagrant/config/pki/lighthouse1-key.pem  /etc/ipsec.d/private/
cp /vagrant/config/pki/lighthouse1-cert.pem /etc/ipsec.d/certs/
cp /vagrant/config/pki/node-a1-cert.pem     /etc/ipsec.d/certs/

sudo ufw allow 500,4500/udp

# To make it similar to nebula
# sudo ifconfig eth1 mtu 1300
# sudo ifconfig eth1 txqueuelen 500
# sudo route add default gw 172.20.1.10 eth1

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
    dpdaction=clear
    keyexchange=ikev2

    ike=aes256gcm128-sha256-curve25519!
    esp=aes256gcm128-sha256-curve25519!

    left=172.20.1.100
    leftid="C=FI, O=VPN lighthouse1, CN=172.20.1.100"
    leftcert=/etc/ipsec.d/certs/lighthouse1-cert.pem
    leftsubnet=0.0.0.0/0    

    right=%any
    rightid="C=FI, O=VPN node-a1, CN=10.40.40.5"
    rightsourceip=10.40.40.5
    rightcert=/etc/ipsec.d/certs/node-a1-cert.pem

EOL


cat >/etc/ipsec.secrets <<EOL
172.20.1.100 : RSA "/etc/ipsec.d/private/lighthouse1-key.pem"
EOL

sudo apt-get install -y iperf3 rsync

sudo cat >/etc/rsyncd.conf  <<EOL
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
log file = /var/log/rsync.log
port = 12000

[files]
path = /vagrant/experiments/13_rsync_ipsec/destination/
comment = Primary file server
read only = no
timeout = 300

EOL

sudo chmod o+w /vagrant/experiments/13_rsync_ipsec/destination/
sudo rsync --daemon

# sudo ipsec restart
