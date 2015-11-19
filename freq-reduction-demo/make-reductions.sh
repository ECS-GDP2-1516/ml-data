#!/bin/bash

dir=$1

while read frequency
do
    mkdir "$dir/reduced/${frequency}hz"

    ls "$dir" | grep 'csv$' |
        while read filename
        do
            if [ ! -f "$dir/reduced/${frequency}hz/$filename" ]
            then
                ../reduce.sh "$frequency" "$dir/$filename" >"$dir/reduced/${frequency}hz/$filename"
                echo "Done $dir/reduced/${frequency}hz/$filename"
            else
                echo "Skipping $dir/reduced/${frequency}hz/$filename, already done"
            fi
        done
done
