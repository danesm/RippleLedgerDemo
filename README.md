# RippleLedgerDemo 

Preface: 

Transactions on the XRP Ledger are communicated and recorded by a network of computers running a software daemon called "rippled." Every few seconds, the network reaches consensus on a new set of transactions which are applied to the old state of the ledger to create a new “validated ledger” that gets broadcast across the network. You can use rippled's server_info command to gather information about the set of validated ledgers that this rippled has received.

Requirements: 

Provide script/program that periodically calls rippled’s server_info command and records the sequence number of the latest validated ledger along with the current time. Record this data in a file. Then, use this data to construct a plot (time on the x-axis, sequence number on the y-axis) that visualizes how frequently the ledger sequence is incremented over time (i.e. how often new ledgers are validated). Choose a time span and polling interval that can effectively capture and depict this information. 

# Solution Pre-requisites 

   1. Install Rippld server on any supported linux platform in order to execute rippled APIs. 
      Installation instructions-  https://xrpl.org/install-rippled.html
      
   2. Install gnuplot (a portable command-line driven graphing utility)
   
   
 # How does the script work? 
 
 There are 2 scripts - 
 
     1. ping-ripple.sh  (This will call rippled server_info command and create data file (data.dat) for plotting graph). 
     2. gnup.gnu (This uses the data file (data.dat) to plot)
     
  In order to execute these scripts follow below steps - 
  
     1. git clone in any folder
     2. Then ./ping-ripple.sh (enter 1 second interval) 
     3. This will create data.dat file of 30 records  
     4. Now run ./gnup.gnu (This will plot data.dat in a graph which will be poped up)
     
     
      Note: 1. If you don't want to install rippled local instance. You may only run gnuplot script to generate graph as data.dat is provided in this repo.
      
            2. If you are running your local rippled server then before running above scripts pls make sure to check rippled     server state is 'full' in this case. 
              More info about server states at - https://xrpl.org/rippled-server-states.html
              e.g. server_info method returns "server_state": "full" or respective value in response JSON object.
      
 
   # How did you decide on polling interval? 
   
   
   The XRP ledger's technology takes three to six seconds for settlement, near realtime. 
   Poll interval of 1 second is taken so we can plot the graph in a way that we first see flat line until a new sequence is generated. There will be spike in curve for every new ledger sequence number against the current time. The smaller the flat line the less time it took for the XRP platform to validate the ledger and vice a versa.
   
 If poll interval is taken in mill seconds we get flat line graph as we are taking sample of 30 records only in this demo.
 For this to work we need to increase the span of time to a lot longer (becaue XRP takes min 3-6 sec) so we have enough data to understand the graph. 
 
 So better option was to use 1 sec interval for small span. It also helps as NTP possibly takes few mill seconds to synchronise participating computers in the network.
 
 # What does the result tell us? 
  
  Every 1-4 seconds a new ledger is added. Occassionally it may be slightly higher than 6 seconds for few ledgers in consensus process. So there is clear variation in time between new ledgers. 
  
 
  # What might explain the variation in time between new ledgers? 
  
XRP Ledger enables peer-to-peer transaction settlement across a decentralized network of computers which participate in concensus process to validate the group of transactions. 
 
There could be some variation in time between the ledgers due to NTP (Network Time Protocol)as every peer needs to  keep its  clock in sync with UTC and and sometimes these peers can be out of sync slightly & may cause minor delay in concensus. 
Also network congetion could also contribute to delay in voting process. 


  
 
 
 

   
