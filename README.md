# ipLogger
Simple Bash script to log ip addresses accesses a web service. One of three function names can be passed as arguments to the script (request_handled, top100, and clear). The request_handled function accepts the ip address as an argument.

### What would I do differently if I had more time?
If I had more time I would have pursued different tools. I know conceptually what memcached and redis do but am not confident in the nuances of both these to accomplish the task in 90 minutes. I would also add in a feature that backs up the log file at the end of each day and automatically creates the new log at the beginning of each day (I'd use cron for this most likely). I'd also validate ip addresses and flag unusually high volumes of requests in case of malicious activity.

### What is the runtime complexity of each function?

The runtime complexity of each of these function is exponential. As more ip addresses get logged, the more work the program has to do to check if the ip is logged, if not log it, if so, increment the visit count. The top100 and clear functions would run into similar issues. 

### How does ipLogger work?

ipLogger is a simple bash program that is able to log and count ip addresses requesting a web service. The desired function is passed as an argument (request_handled, top100, or clear) to the script and the desired function is carried out.

Request_handled takes the ip address and evaluates whether or not this ip address has been logged previously. If it has, the number of visitations in the log file is incremented by one. If it has not yet been logged for that day, it is logged in the requestingIps.log file.

The top100 function returns a list of 100 ip addresses that have requested the service most often. This is accomplished with a series of bash commands (awk piped to sort piped to head). 

The clear function clears the contents of the requestingIps.log file. 

#### request_handled example:

    ./ipLogger.sh request_handled 192.168.1.1
    
#### top100 example:

    ./ipLogger.sh top100
    
    sample output
    
    198.56.123(2) 127.0.0.1(1) ...
    
    
#### clear example:

    ./ipLogger.sh clear
    

### What other approaches did I decide not to pursue?

One approach I would have liked to pursue in this iteration would have been keeping a file that had the running top 100 ip logs. Each time an ip visited, I would have evaluated it against the current top 100 and moved it to the top 100 file if it deserved to be there. The retrieval time for the top100 function would have been much faster had I implemented this. The reason I didn't is time.

### How would I test this?

First of all, I wouldn't run initial tests on production. Second, I would create several files of different sizes containing ip addresses. I'd run these through the 3 functions and monitor run times and machine resources to see how performant and accurate the functions were.
