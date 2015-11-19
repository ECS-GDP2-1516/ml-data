#!/bin/bash

linefile="$1"

ls reduced | sort -V | sed 's/hz//' |
    while read freq
    do
        java -cp ~/university/weka-3-6-13/weka.jar weka.classifiers.functions.RBFNetwork -B 4 -S 1 -R 1.0E-8 -M -1 -W 0.1 -t "reduced/${freq}hz/all.arff" -m /tmp/3-class.cost | grep 'Average Cost' | tail -n1 | awk '{print '"$freq"' " " $3}'
    done
