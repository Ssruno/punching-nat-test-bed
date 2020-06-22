#!/usr/bin/env bash

host="192.200.1.100"
quantity=$1
file_path=$2


case $quantity in

  10)
    destination="/vagrant/experiments/02_nebula_small_files/destination/d_10"
    ;;

  100)
    destination="/vagrant/experiments/02_nebula_small_files/destination/d_100"
    ;;

  500)
    destination="/vagrant/experiments/02_nebula_small_files/destination/d_500"
    ;;

  1000)
    destination="/vagrant/experiments/02_nebula_small_files/destination/d_1000"
    ;;

  5000)
    destination="/vagrant/experiments/02_nebula_small_files/destination/d_5000"
    ;;
esac

# echo $destination

for i in $( seq 1 $quantity )
do
    # echo $file_path $destination $i
  scp -q $file_path vagrant@$host:$destination/$i.dat &
  #echo "scp -q file_path vagrant@$host:$destination/$i.dat &"
done

wait
