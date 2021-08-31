#!/bin/bash

CLI=$1
log="/bounty/queue/crawler.log"

echo "[+][-] Waybackuls"
echo
echo "cat /bounty/$CLI/urls.txt | waybackurls >> /bounty/$CLI/temp/waybackurls.txt" >> $log

echo "[+][-] Gauplus"
echo
echo "cat /bounty/$CLI/urls.txt | gauplus >> /bounty/$CLI/temp/gauplus.txt" >> $log
