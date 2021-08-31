#!/bin/bash

CLI=$1
log="/bounty/queue/xss.log"

echo "[+][-] Dalfox"
echo
echo "cat /bounty/$CLI/urls_param.txt | Gxss |dalfox pipe --silence | notify" >> $log

echo "[+][-] Dalfox + GF"
echo

for i in $(cat /bounty/$CLI/urls_crawler.txt);do
       	echo "echo $i | gf xss | dalfox pipe --silence --skip-bav | notify" >> $log
done
for i in $(cat /bounty/$CLI/urls_param.txt);do
       	echo "echo $i | gf xss | dalfox pipe --silence --skip-bav | notify" >> $log
done
for i in $(cat /bounty/$CLI/urls.txt);do
       	echo "echo $i | gf xss | dalfox pipe --silence --skip-bav | notify" >> $log
done
