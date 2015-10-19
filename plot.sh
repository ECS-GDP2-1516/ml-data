#!/bin/bash

( echo -e "set datafile separator ','\nplot '$1' using 1:2 with lines title columnhead, '' using 1:3 with lines title columnhead, '' using 1:4 with lines title columnhead" && cat ) | gnuplot --persist
