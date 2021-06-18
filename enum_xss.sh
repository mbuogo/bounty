#!/bin/bash

CLI=$1

echo "[+] DALFOX"
echo
cat /bounty/$CLI/url_param.txt | Gxss | dalfox pipe | notify

echo "[+] XSStrike"
echo
for xss in $(cat /bounty/$CLI/url_param.txt);do
        cd /opt/XSStrike/; python3 xsstrike.py -u $xss --file /wordlists/XSS-OFJAAAH.txt >> /bounty/$CLI/logxss.log
        echo $xss | notify
        for x in $(cat /bounty/$CLI/logxss.log);do
               echo $x | notify
        done
        rm -rf /bounty/$CLI/logxss.log  
done
