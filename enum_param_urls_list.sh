#!/bin/bash

CLI=$1
log1="/bounty/queue/params-arjun1.log"
log2="/bounty/queue/params-arjun2.log"
log3="/bounty/queue/params-paramspider1.log"
log4="/bounty/queue/params-paramspider2.log"

echo "[+][-] ARJUN1"
echo
for i in $(cat /bounty/$CLI/urls.txt);do
	echo "arjun -u $i -oT /bounty/$CLI/temp/$(uuidgen | cut -d"-" -f1)-arjun.txt" >> $log1
done
echo "[+][-] ARJUN2"
for i in $(cat /bounty/$CLI/urls_crawler.txt);do
        echo "arjun -u $i -oT /bounty/$CLI/temp/$(uuidgen | cut -d"-" -f1)-arjun.txt" >> $log2
done

echo
echo "[+] PARAMSPIDER"
echo
for i in $(cat /bounty/$CLI/urls.txt);do
	echo "/opt/ParamSpider/paramspider.py --domain $i -o /bounty/$CLI/temp/$(uuidgen | cut -d"-" -f1)-paramspider.txt" >> $log3
done

echo "[+] PARAMSPIDER"
echo
for i in $(cat /bounty/$CLI/urls_crawler.txt);do
        echo "/opt/ParamSpider/paramspider.py --domain $i -o /bounty/$CLI/temp/$(uuidgen | cut -d"-" -f1)-paramspider.txt" >> $log4
done

cat $log1 $log2 $log3 $log4 | anew /bounty/queue/param.log
