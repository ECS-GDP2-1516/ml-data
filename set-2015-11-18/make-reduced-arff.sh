#!/bin/bash

linefile="$1"

ls reduced | sort -V | sed 's/hz//' |
    while read freq
    do
        cat "$linefile" | sed 's/^/reduced\/'"$freq"'hz\//' >"reduced/${freq}hz/all.lines"
        ../find-and-format.sh "reduced/${freq}hz/all.lines" "$freq" >"reduced/${freq}hz/all.arff"
        echo "Done ${freq}hz"
    done
