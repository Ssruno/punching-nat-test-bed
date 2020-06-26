#!/usr/bin/env bash

for iteration in {1..180}
# for iteration in {1..12}
do        
    nc -l -p 1234 > /home/vagrant/out.file
done


