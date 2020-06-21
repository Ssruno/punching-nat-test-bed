#!/usr/bin/env bash

#sudo /vagrant/files/nebula -config /vagrant/config/node-a1/config.yml &

# We generate files with random content.
head -c 1M    < /dev/urandom > /vagrant/benchmark/origin/01_origin_file_0001M.dat
#head -c 10M   < /dev/urandom > /vagrant/benchmark/origin/02_origin_file_0010M.dat
#head -c 50M   < /dev/urandom > /vagrant/benchmark/origin/03_origin_file_0050M.dat
#head -c 100M  < /dev/urandom > /vagrant/benchmark/origin/04_origin_file_0100M.dat
#head -c 500M  < /dev/urandom > /vagrant/benchmark/origin/05_origin_file_0500M.dat
#head -c 1000M < /dev/urandom > /vagrant/benchmark/origin/06_origin_file_1000M.dat

# We generate key-pair for scp or rsync without passphrase
ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
# We append the public key of the destination into our authorized_keys file
cat /vagrant/benchmark/destination/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
