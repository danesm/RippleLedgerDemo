# RippleLedgerDemo 

Preface: 

Transactions on the XRP Ledger are communicated and recorded by a network of computers running a software daemon called "rippled." Every few seconds, the network reaches consensus on a new set of transactions which are applied to the old state of the ledger to create a new “validated ledger” that gets broadcast across the network. You can use rippled's server_info command to gather information about the set of validated ledgers that this rippled has received.

Requirements: 

Provide script/program that periodically calls rippled’s server_info command and records the sequence number of the latest validated ledger along with the current time. Record this data in a file. Then, use this data to construct a plot (time on the x-axis, sequence number on the y-axis) that visualizes how frequently the ledger sequence is incremented over time (i.e. how often new ledgers are validated). Choose a time span and polling interval that can effectively capture and depict this information. 

# Solution Pre-requisites 

   1. The scripts use Ripple's public instace s1.ripple.com, however it is tested with local instance of rippled on ubuntu linux too. 
   
   2. You may also install Rippled server on any supported linux platform in order to execute rippled APIs locally. 
      Installation instructions-  https://xrpl.org/install-rippled.html
      
   2. Install gnuplot (a portable command-line driven graphing utility) and curl 
   
   
   
 # How does the script work? 
 
 There are 2 scripts - 
 
     1. ping-ripple.sh  (This will call rippled server_info command and create data file (data.dat) for plotting graph). 
     2. gnup.gnu (This uses the data file (data.dat) to plot graph)
     
  In order to execute these scripts follow below steps - 
  
     1. git clone in any folder
     2. Then ./ping-ripple.sh (It takes user input -  poll interval & time span in seconds) 
     3. Then it will create data.dat file.   
     4. Now run ./gnup.gnu (This will plot data.dat in a graph which will be poped up)
     
     
     
Note: 
If you are running your local rippled server then before running above scripts pls make sure to check rippled server state is 'full' meaning server has connected to XRP Ledger peer-to-peer network. 
More info about server states at - https://xrpl.org/rippled-server-states.html
e.g. server_info method returns "server_state": "full" or respective value in response JSON object.
      
 
   # How to decide on polling interval? 
   
The XRP ledger's technology takes three to six seconds for settlement, near realtime. 
Poll interval of 1 second is taken so we can plot the graph in a way that we first see flat line until a new sequence is    generated.There will be spike in curve for every new ledger sequence number against the current time. The smaller the flat line the less time it took for the XRP platform to validate the ledger and vice a versa.

Test was done on poll interval range from 0.1 mill sec to 1 sec interval with 20 sec of time span. And it gave clear understanding that it takes more than a second to validate the XRP ledger as we can see duplicate records coming as we reduce the poll interval. i.e. Duplicate seq number increases more with reduction of poll interval so 1 sec poll interval was used to have a easy to read graph with interval in seconds.    

 Pls see attached example pdf file based on 1 sec poll interval for 20 sec span. 
 However the provided script are dynamic enough to test with any interval and span parameter at run time. 
 
 # What does the result tell? 
  
  Every 1-4 seconds a new ledger is added. Occassionally it may be slightly higher than 3-4 seconds for few ledgers in consensus process. There is clear variation in time between new ledgers. 
 

  # What might explain the variation in time between new ledgers? 
  
XRP Ledger enables peer-to-peer transaction settlement across a decentralized network of computers which participate in concensus process to validate the group of transactions. 

There could be some variation in time between the ledgers as all peer uses NTP for keeping their clock in sync with UTC and occassionally nodes can be out of sync just slightly and they may cause overlaps in concensus process. 

Also network congestion could play role in delay in voting process. 


 #  Challange : 

  1. Enhance the script to calculate the min, max, and average time that it took for a new ledger to be validated during the span of time captured. 

     Gnuplot stats can be used to calculate min, max and average.




  2. There are some other (better) ways that you could use the rippled API to find how long each ledger took to close/validate. Using the API documentation, find and describe one of these methods. 
 
One way could be to use Ripple public API’s ‘Ledger Methods’. 

 Ledger Methods provides a method called ‘ledger’ which can be called using webSocket/Json-rpc or command line. 
 The response of this method call is as follows- 

{

  "id": 14,

  "result": {

    "ledger": {

      "accepted": true,

      "account_hash": "53BD4650A024E27DEB52DBB6A52EDB26528B987EC61C895C48D1EB44CEDD9AD3",

      "close_flags": 0,

      "close_time": 638329241,

      "close_time_human": "2020-Mar-24 01:40:41.000000000 UTC",

      "close_time_resolution": 10,

      "closed": true,

      "hash": "1723099E269C77C4BDE86C83FA6415D71CF20AA5CB4A94E5C388ED97123FB55B",

      "ledger_hash": "1723099E269C77C4BDE86C83FA6415D71CF20AA5CB4A94E5C388ED97123FB55B",

      "ledger_index": "54300932",

      "parent_close_time": 638329240,

      "parent_hash": "DF68B3BCABD31097634BABF0BDC87932D43D26E458BFEEFD36ADF2B3D94998C0",

      "seqNum": "54300932",

      "totalCoins": "99991024049648900",

      "total_coins": "99991024049648900",

      "transaction_hash": "50B3A8FE2C5620E43AA57564209AEDFEA3E868CFA2F6E4AB4B9E55A7A62AAF7B"

    },

    "ledger_hash": "1723099E269C77C4BDE86C83FA6415D71CF20AA5CB4A94E5C388ED97123FB55B",

    "ledger_index": 54300932,

    "validated": true

  },

  "status": "success",

  "type": "response"

}

Where following response fileds (integers) can be used, 

ledger.parent_close_time	-         The time at which the previous ledger was closed.

ledger.close_time	        -  The time this ledger was closed, in seconds since the Ripple Epoch


So ,

Time to close / validate Ledger =  ( ledger.close_time  - ledger.parent_close_time ) in seconds. 









  




 
 

   
