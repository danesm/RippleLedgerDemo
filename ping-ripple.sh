#---------------------------------------------------------------------------------------
# author:  @danesm 
# date  :  20-June-2020 
# Handling: This script provides option to run on local rippld or public instance (http://s1.ripple.com:51234 )
#           By default it uses  public url to collect ledger information.      
#           To use local rippld instance , uncomment line #27 and comment line#29   
#---------------------------------------------------------------------------------------
#!/bin/bash

read -p "Enter Polling Interval (in seconds, e.g. 1 or 2): " pollint
read -p "Enter Time Span (in seconds e.g. 10, 20, 60 etc ): " tspan
echo ""
echo "You are calling rippled’s server_info command every $pollint seconds for $tspan seconds"
  
echo "============================================================================="
sleep 2;
# create dir for storing output file.
outfile="$(pwd)/data.dat"

echo -n "" > $outfile
cd /etc/opt/ripple/

endTime=$(( $(date +%s) + $tspan )) # Calculate end time.

while [ $(date +%s) -lt $endTime ]; do  # Loop until interval has elapsed.

#rippled server_info | grep -e '"seq"' -e '"time"'  | awk '{print}' ORS='" ' | awk '{print $0,"\n"}' | less | sed -e 's/^[ \t]*//' >> $outfile
    
curl -d '{"method":"server_info", "params":""}' -H "Content-Type: application/json" -X POST http://s1.ripple.com:51234 | json_pp | grep -e '"seq"' -e '"time"'  | awk '{print}' ORS='" ' | awk '{print $0,"\n"}' | less | sed -e 's/^[ \t]*//' >> $outfile

sleep $pollint; # Sleep for the pool interval.
    
done

# File formatting required for gnuplot data file.
sed -i 's/'time'/''/g' $outfile
sed -i 's/'seq'/''/g'  $outfile
sed -i 's/'\"'/''/g'  $outfile
sed -i 's/'UTC'/''/g'  $outfile
sed -i 's/'\:'/''/g' $outfile
sed -i '/^$/d' $outfile 


