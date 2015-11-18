#!/bin/bash

file=$1
xmin=$2
xmax=$3
ymin=$4
ymax=$5

pwd

while read frequency
do
    tmpfile=`date +%s%N`
    ../reduce.sh "$frequency" "$file" >"/tmp/$tmpfile".csv
    ./print-plot.sh "/tmp/$tmpfile".csv "images/$frequency" "$xmin" "$xmax" "$ymin" "$ymax"
    rm "/tmp/$tmpfile".csv
    echo "$frequency Hz done"
done
