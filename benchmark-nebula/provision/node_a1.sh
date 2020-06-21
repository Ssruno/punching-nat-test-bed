#!/usr/bin/env bash

#sudo /vagrant/files/nebula -config /vagrant/config/node-a1/config.yml &

# We generate files with random content.
head -c 1M    < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/01_origin_file_0001M.dat
head -c 10M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/02_origin_file_0010M.dat
head -c 50M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/03_origin_file_0050M.dat
head -c 100M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/04_origin_file_0100M.dat
head -c 500M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/05_origin_file_0500M.dat
head -c 1000M < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/06_origin_file_1000M.dat

# We generate key-pair for scp or rsync without passphrase
# ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# Manually run this
# ssh-copy-id -i id_rsa.pub vagrant@192.200.1.100
