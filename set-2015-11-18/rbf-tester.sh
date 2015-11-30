#!/bin/bash

files=`while (( "$#" ))
do
    echo $1
    shift
done`

echo "$files" | while read testfile
do
    trainfiles=`echo "$files" | grep -v "$testfile"`
    echo "$trainfiles" | xargs cat >/tmp/linefile_all

    ../find-and-format.sh /tmp/linefile_all 100 >/tmp/train.arff
    ../find-and-format.sh $testfile 100 >/tmp/test.arff

    java -cp ~/university/weka-3-6-13/weka.jar weka.classifiers.functions.RBFNetwork -B 2 -S 1 -R 1.0E-8 -M -1 -W 0.1 -t /tmp/train.arff -T /tmp/test.arff | fgrep 'Correctly Classified Instances' | tail -n 1
done
