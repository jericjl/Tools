#!/usr/bin
for line in `cat dns_expiring.txt| awk -F '=' '{print $NF}'`; do nslookup $line; done
for i in `cat dns.txt | awk -F 'Name=' '{print $NF}'`; do nslookup $i; done

$ for i in `cat dns.txt` ; do nslookup $i 2>/dev/null | tail -n 1 ; done

cat address_list |grep -c 'Address:' | awk -F ':' '{print $2}' 
