#!/usr/bin/env bash

for iteration in {1..180}
do        
    nc -l -p 1234 | uncompress -c | tar xvfp - > /home/vagrant/out.file
done


