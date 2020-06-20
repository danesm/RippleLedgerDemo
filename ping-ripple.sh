#!/bin/bash

read -p "Enter Polling Interval (in seconds, e.g. 1 or 2): " pollint

echo "This script will call rippled’s server_info command every $pollint seconds "
echo "============================================================================="

# create dir for storing output file.
outfile="$(pwd)/data.dat"

echo -n "" > $outfile

cd /etc/opt/ripple/

for i in {1..30}; do

rippled server_info | grep -e '"seq"' -e '"time"'  | awk '{print}' ORS='" ' | awk '{print $0,"\n"}' | less | sed -e 's/^[ \t]*//' >> $outfile

sleep $pollint; 
done

#File formatting for gnuplot.
sed -i 's/'time'/''/g' $outfile
sed -i 's/'seq'/''/g'  $outfile
sed -i 's/'\"'/''/g'  $outfile
sed -i 's/'UTC'/''/g'  $outfile
sed -i 's/'\:'/''/g' $outfile
sed -i '/^$/d' $outfile 


#cat $outfile | sed 's/^[ \t]*//;s/[ \t]*$//' > $outfile

