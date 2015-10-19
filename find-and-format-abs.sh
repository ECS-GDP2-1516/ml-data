#!/bin/bash

NUMBEROFARGS=4;

if [ $# -lt $NUMBEROFARGS ]
then
	>&2 echo -e "Usage is:\n find-and-format.sh (line file) (sample count) (output location) (input file) [input files...]"
	exit 1;
else
	LINEFILE=$1; shift;
	SAMPLECOUNT=$1; shift;
	OUTPUTLOCATION=$1; shift;
fi

CLASSES=`cat "$LINEFILE" | cut -f 3 | sort | uniq | paste -sd "," - `

echo -e "% Data generated on `date`
% by find-and-format
% produced by Daniel Playle (dan@dan.re)
%
@RELATION gdp
"

for i in $(seq 1 $SAMPLECOUNT);
do
	echo -e "@ATTRIBUTE abs$i NUMERIC"
done

echo -e "@ATTRIBUTE class {$CLASSES}

@DATA"

if [ $((SAMPLECOUNT%2)) -eq 0 ]
then # even
	BEFORE=$((SAMPLECOUNT/2));
	AFTER=$((BEFORE-1));
else # odd
	BEFORE=$(((SAMPLECOUNT-1)/2));
	AFTER=$BEFORE;
fi

cat "$LINEFILE" | while read line
do
	FILE=`echo "$line" | cut -f 1`
	TIME=`echo "$line" | cut -f 2`
	CLASS=`echo "$line" | cut -f 3`
	grep -B "$BEFORE" -A "$AFTER" "^$TIME" "$FILE" | head -n "$SAMPLECOUNT" | cut -f 2- -d',' | tr ',' ' ' | awk '{print sqrt($1*$1 + $2*$2 + $3*$3)}' | tr '\n' ','
	echo "$CLASS";
done
