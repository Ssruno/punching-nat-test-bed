#!/usr/bin/env bash


# We generate files with random content.
# head -c 1M    < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/01_origin_file_0001M.dat
# head -c 10M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/02_origin_file_0010M.dat
# head -c 50M   < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/03_origin_file_0050M.dat
# head -c 100M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/04_origin_file_0100M.dat
# head -c 500M  < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/05_origin_file_0500M.dat
# head -c 1000M < /dev/urandom > /vagrant/experiments/01_nebula_delay/origin/06_origin_file_1000M.dat

destination="192.200.1.100"
size_of_files=(1M 10M 50M 100M 500M 1000M)
# size_of_files=(1000M)
#name_of_files=(ls  /vagrant/benchmark/origin/*.dat | xargs -n1 basename)
#name_of_files=()
name_of_files=(01_origin_file_0001M.dat 02_origin_file_0010M.dat 03_origin_file_0050M.dat 04_origin_file_0100M.dat 05_origin_file_0500M.dat 06_origin_file_1000M.dat)
# name_of_files=(06_origin_file_1000M.dat)
#for i in `ls /vagrant/benchmark/origin/*.dat` ;do name_of_files+=(basename $i);done

#echo ${name_of_files[@]}



## { /usr/bin/time  -f "%e, 1024" scp -q /vagrant/benchmark/origin/01_origin_file_0001M.dat vagrant@172.20.1.100:/vagrant/benchmark/destination/ ; } 2>> /vagrant/benchmark/results/delay.csv

# file=0

for file in {0..5}
do
    echo "----------------------"
    echo "Processing ${size_of_files[$file]}; ${name_of_files[$file]}"
    echo "----------------------"
    echo "seconds;size;filename;iteration" > /vagrant/experiments/12_rsync_nebula/results/12_result_${size_of_files[$file]}.csv
    for iteration in {1..30}
    do        
        # echo " $iteration"
        { /usr/bin/time  -f "%e; ${size_of_files[$file]}; ${name_of_files[$file]}; $iteration" rsync -W /vagrant/experiments/12_rsync_nebula/origin/${name_of_files[$file]} rsync://$destination:12000/files/ ; } 2>> /vagrant/experiments/12_rsync_nebula/results/12_result_${size_of_files[$file]}.csv
        sleep 1
    done
    echo "sleep 1 second"
    sleep 1
    echo "Go!"
done

