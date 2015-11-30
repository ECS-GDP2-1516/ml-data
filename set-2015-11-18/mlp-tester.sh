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

    java -cp ~/university/weka-3-6-13/weka.jar weka.classifiers.functions.MultilayerPerceptron -L 0.3 -M 0.2 -N 500 -V 0 -S 0 -E 20 -H 4 -B -C -I -t /tmp/train.arff -T /tmp/test.arff | fgrep 'Correctly Classified Instances' | tail -n 1
done
