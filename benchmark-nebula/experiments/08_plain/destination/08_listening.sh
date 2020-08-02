#!/usr/bin/env bash

for iteration in {1..180}
# for iteration in {1..30}
do        
    nc -l -p 1234 > /vagrant/experiments/08_plain/destination/out.file    
done


