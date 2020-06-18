#!/bin/bash

read -p "Enter Polling Interval (in seconds): " pollint
#read -p "Enter a number to say how many polls required: " pollcount

echo "This script will call rippled’s server_info command every $pollint seconds "
echo "============================================================================="


#echo "This script will poll rippled’s server for $pollcount times "

# create dir for storing output file.
outfile="$(pwd)/data50.dat"
#mkdir -p ~/ripple-demo
echo -n "" > $outfile
#echo "  Time                                     Seq" >> $outfile

cd /etc/opt/ripple/

for i in {1..50}; do

rippled server_info | grep -e '"seq"' -e '"time"'  | awk '{print}' ORS='" ' | awk '{print $0,"\n"}' | less | sed -e 's/^[ \t]*//' >> $outfile

sleep $pollint; done

#File formatting for gnuplot.
sed -i 's/'time'/''/g' $outfile
sed -i 's/'seq'/''/g'  $outfile
sed -i 's/'\"'/''/g'  $outfile
sed -i 's/'UTC'/''/g'  $outfile
sed -i 's/'\:'/''/g' $outfile
sed -i '/^$/d' $outfile 


#cat $outfile | sed 's/^[ \t]*//;s/[ \t]*$//' > $outfile

