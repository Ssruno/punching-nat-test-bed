#!/usr/bin/env bash

for iteration in {1..180}
# for iteration in {1..5}
do        
    # nc -l -p 1234 > /home/vagrant/out.file
    nc -l -p 1234 > /vagrant/experiments/06_ipsec_netcat_delay/destination/out.file    
done


