#!/usr/bin/gnuplot -persist

#Enable terminal and output command for storing plot output in file system as PDF file. 
#set terminal pdf
#set output "MyPlot.pdf"

set title  'XRP Ledger data'
set xlabel "Time (HH:MM:SS)"
set ylabel "Seq Number"
#set yrange [100000:]
#set yrange [0 : 3.0e7]
#set format y "%.0b million"
#set format y "%.0s*10^{%T}"
set xdata time 
set timefmt "%Y-%b-%d %H%M%S" 
set format x "%H:%M\n:%S"
set key left
set grid
set autoscale
set size 1,1
set datafile separator ','

# ploting graph from the data provided by data.dat file.
plot "data.dat" using 1:2 with lines title "Latest Validated Ledgers as of ".strftime("%b %d %Y", time(0)) 

exit
