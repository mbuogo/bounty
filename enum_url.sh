#!/bin/bash

DOMAIN=$1
CLI=$2

rm -rf /bounty/$CLI/urls.txt

echo "[+] SUDOMY"
echo
cat /bounty/$CLI/$DOMAIN/Sudomy-Output/$DOMAIN/httprobe_subdomain.txt >> /bounty/$CLI/urls.txt
echo "[+] HTTPX"
echo
cat /bounty/$CLI/subdomains.txt | httpx -silent -o /bounty/$CLI/urls-httpx.txt
cat /bounty/$CLI/urls-httpx.txt | anti-burl | awk '{print $4}' | anew /bounty/$CLI/urls.txt
echo "[+] URL ESPECIFICAS"
echo
cat /bounty/$CLI/urls_especificas.txt | anew /bounty/$CLI/urls.txt
