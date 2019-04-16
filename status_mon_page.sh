#!/bin/bash
#### Status_monitoring_page
#### Version 0.1
####
#### dependencies - timelimit & python3 (for simple http Webserver)
#### apt-get install timelimit
#### apt-get install python3



#% forever 10 # in seconds
while true
do
date > index.html 
echo "<br>" >> index.html
###
#this is a simple mysql check based on open port
MYSQLHost=localhost
MYSQLPort=3306

timeout 1 bash -c "</dev/tcp/${MYSQLHost}/${MYSQLPort}"; echo $?
if [ "$?" -ne 0 ]; then
  echo "MYSQL Service DOWN"
  #exit 1
else
  echo "MYSQL Service UP" >> index.html
  #exit 0
fi

echo -e "\n <br>"  >> index.html
#echo "next" 
######################################################################

###
#this is a simple kopano check based on open port
KOPANOHost=localhost
KOPANOPort=237 #237

timeout 1 bash -c "</dev/tcp/${KOPANOHost}/${KOPANOPort}"; echo $?
if [ "$?" -ne 0 ]; then
  echo "kopano Service DOWN"
  #exit 1
else
  echo "Kopano Service UP" >> index.html
  #exit 0
fi
#echo "next" 
######################################################################


# finaly loading simple http server
#only for 10 Sec

timelimit -t 10 python -m SimpleHTTPServer
done