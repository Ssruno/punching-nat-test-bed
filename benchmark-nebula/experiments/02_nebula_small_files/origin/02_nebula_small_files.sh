#!/usr/bin/env bash


# We generate files with random content.
head -c 100K    < /dev/urandom > /vagrant/experiments/02_nebula_small_files/origin/02_origin_file_0100K.dat




filename_to_send="/vagrant/experiments/02_nebula_small_files/origin/02_origin_file_0100K.dat"

quantity_of_files_to_send=(10 100 500 1000 5000)

rate=(5 10 20)

echo "seconds;size;quantity;rate;iteration" > /vagrant/experiments/02_nebula_small_files/results/02_nebula_small_files_results.csv


# five rounds (iterations) of sending files at a given rate.
for iteration in {1..5}
do

    # # How many files are we sending
    for quantity in {0..4}
    do
    #     # There are three values in the rate array
        for seconds in {0..2}
        do 
            { /usr/bin/time  -f "%e; 100K; ${quantity_of_files_to_send[$quantity]}; ${rate[$seconds]}; $iteration"  bash /vagrant/experiments/02_nebula_small_files/origin/aux_send_file.sh ${quantity_of_files_to_send[$quantity]} $filename_to_send ; } 2>> /vagrant/experiments/02_nebula_small_files/results/02_nebula_small_files_results.csv
            # wait certain amount of seconds until next iteration
            sleep ${rate[$seconds]}
            # echo $iteration $quantity $seconds
        done
    done
done