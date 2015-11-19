#!/bin/bash

linefile="$1"

ls reduced | sort -V | sed 's/hz//' |
    while read freq
    do
        for n in {0..10}
        do
            for seed in {0..0}
            do
                java -cp ~/university/weka-3-6-13/weka.jar weka.classifiers.functions.MultilayerPerceptron -L 0.3 -M 0.2 -N 50 -V 0 -S "$seed" -E 20 -H "$n" -B -C -I -t "reduced/${freq}hz/all.arff" -m /tmp/3-class.cost -T /tmp/test.arff | grep 'Average Cost' | tail -n1 | awk '{print $3}'
            done |
                paste -sd+ - | bc | awk '{print '"$freq"' " " '"$n"' " " $1/1}'
        done
        echo ''
    done
