#!/usr/bin/gnuplot -persist

#Enable terminal and output command for storing plot output in file system as PDF file. 
#set terminal pdf
#set output "MyPlot.pdf"
set title  'Ripple XRP Ledger data'
set xlabel "Time (HH:MM:SS)"
set ylabel "Seq Number"
set xdata time 
set timefmt "%Y-%b-%d %H%M%S" 
set format x "%H:%M\n:%S"
set format y "%.2f"
set key left
set grid
set autoscale
set size 1,1
set datafile separator ','

plot "data.dat" using 1:2 with lines title "Validated Ledgers as of".strftime("%b %d %Y", time(0))


exit
