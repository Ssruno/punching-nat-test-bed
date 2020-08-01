#!/usr/bin/env bash

# for iteration in {1..10}
for iteration in {1..180}
do        
    nc -l -p 1234 > /home/vagrant/out.file
done


