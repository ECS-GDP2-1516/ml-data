#!/bin/bash

dir=$1

while read frequency
do
    mkdir "$dir-${frequency}hz"

    ls "$dir" | grep 'csv$' |
        while read filename
        do
            ../reduce.sh "$frequency" "$dir/$filename" >"$dir-${frequency}hz/$filename"
            echo "Done $dir-${frequency}hz/$filename"
        done
done
