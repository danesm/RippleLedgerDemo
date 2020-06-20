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
     
     
      Note: If you don't want to install rippled local instance. You may only run gnuplot script to generate graph as data.dat is provided in this repo.
 
   
   
