#!/bin/bash

#what is my public ip
ip=$(curl ifconfig.me)

#to compare
ip2=$(cat mydns.txt)

# compare ips, if ips are direfent ->  update dns.
if [ "$ip" = "$ip2" ]; 
then 
echo "same ips, no need update"
else
date >> dns.log
ssh  root@plesk.host  "plesk bin dns -d domain.com -a 'subdomain' -ip $ip2" >> dns.log
ssh  root@plesk.host  "plesk bin dns -a domain.com -a 'subdomain' -ip $ip" >> dns.log
echo $ip > mydns.txt
fi
