#!/usr/bin/gnuplot -persist
#set terminal pdf
#set output "MyPlot.pdf"
set title 'Rippled Poll data'
set xlabel "Time"
set ylabel "Seq Number"
#set yrange [100000:]
set xdata time
set timefmt "%Y-%b-%d %H%M%S" 
set format x "%T"
set key left
set grid
set autoscale
set datafile separator ','
plot "data.dat" using 1:2 with lines title "Latest Validated Ledgers as of".strftime(" %b %d %Y", time(0))


exit
