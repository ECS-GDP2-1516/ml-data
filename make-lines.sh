#!/bin/bash

FILE=$1;
CLASS=$2;


while [ -n "$3" ]
do
    echo -e "$FILE\t$3\t$CLASS";
    shift;
done
