#!/bin/bash

CLI=$1
log="/bounty/queue/urls.log"

cat /bounty/$CLI/urls_especificas.txt | anew /bounty/$CLI/urls.txt

echo "[+][-] HTTPX"
echo
echo "cat /bounty/$CLI/subdomains.txt | httpx -silent -o /bounty/$CLI/temp/httpx.txt" >> $log

echo "[+][-] HTTPROBE"
echo
echo "cat /bounty/$CLI/subdomains.txt | httprobe >> /bounty/$CLI/temp/httprobe.txt" >> $log
