#!/usr/bin/gnuplot -persist
#set terminal pdf
#set output "MyPlot.pdf"
set title 'Rippled Poll data'
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
set datafile separator ','


#stats 'data.dat' using 1:2 prefix "A"
#set arrow 1 from A_index_min, graph 0.1 to A_index_min, A_min fill
#set arrow 2 from A_index_max, graph 0.9 to A_index_max, A_max fill


plot "data.dat" using 1:2 with lines title "Latest Validated Ledgers as of".strftime("%b %d %Y", time(0))


exit
