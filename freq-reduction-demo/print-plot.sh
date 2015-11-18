#!/bin/bash

( echo -e "set datafile separator ','\nset xlabel 'Time / seconds'\nset ylabel 'Accelerometer Force / g'\nplot '$1' using 1:2 with lines title columnhead, '' using 1:3 with lines title columnhead, '' using 1:4 with lines title columnhead\nset xrange [$3:$4]\nset yrange [$5:$6]\nset term png size 1440,900\nset output '`echo ""$2""`.png'\nreplot\nset term x11 reset") | gnuplot
