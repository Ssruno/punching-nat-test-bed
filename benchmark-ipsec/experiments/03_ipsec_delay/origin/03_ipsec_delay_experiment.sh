#!/usr/bin/env bash

# We generate files with random content.
# head -c 1M    < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/01_origin_file_0001M.dat
# head -c 10M   < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/02_origin_file_0010M.dat
# head -c 50M   < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/03_origin_file_0050M.dat
# head -c 100M  < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/04_origin_file_0100M.dat
# head -c 500M  < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/05_origin_file_0500M.dat
# head -c 1000M < /dev/urandom > /vagrant/experiments/03_ipsec_delay/origin/06_origin_file_1000M.dat

destination="172.20.1.100"
size_of_files=(1M 10M 50M 100M 500M 1000M)
# size_of_files=(500M 1000M)

name_of_files=(01_origin_file_0001M.dat 02_origin_file_0010M.dat 03_origin_file_0050M.dat 04_origin_file_0100M.dat 05_origin_file_0500M.dat 06_origin_file_1000M.dat)
# name_of_files=(05_origin_file_0500M.dat 06_origin_file_1000M.dat)


echo "seconds;size;filename;iteration" > /vagrant/experiments/03_ipsec_delay/results/03_ipsec_delay_MTU_results.csv

for file in {0..5}
do
# file=1
    for iteration in {1..30}
    do        
        echo "${size_of_files[$file]}; ${name_of_files[$file]}; $iteration"
        { /usr/bin/time  -f "%e; ${size_of_files[$file]}; ${name_of_files[$file]}; $iteration" scp -q  /vagrant/experiments/03_ipsec_delay/origin/${name_of_files[$file]} vagrant@$destination:/vagrant/experiments/03_ipsec_delay/destination/ ; } 2>> /vagrant/experiments/03_ipsec_delay/results/03_ipsec_delay_MTU_results.csv
    done
done

# file=5
# for iteration in {1..30}
# do        
#     echo "${name_of_files[$file]} - $iteration"
#     { /usr/bin/time  -f "%e; ${size_of_files[$file]}; ${name_of_files[$file]}; $iteration" scp -q  /vagrant/experiments/03_ipsec_delay/origin/${name_of_files[$file]} vagrant@$destination:/vagrant/experiments/03_ipsec_delay/destination/ ; } 2>> /vagrant/experiments/03_ipsec_delay/results/03_ipsec_delay_results.csv
# done