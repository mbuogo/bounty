#!/bin/bash

DOMAIN=$1
CLI=$2

echo "[+] AMASS $DOMAIN"
echo
rm -rf /bounty/$CLI/amass-dns.txt
amass enum -d $DOMAIN >> /bounty/$CLI/amass-dns.txt
echo "[+] ASSETFINDER $DOMAIN"
echo
rm -rf /bounty/$CLI/assetfinder-dns.txt
assetfinder -subs-only $DOMAIN >> /bounty/$CLI/assetfinder-dns.txt
echo "[+] SUDOMY $DOMAIN"
echo
rm -rf /bounty/$CLI/sudomy-dns.txt
cd /opt/Sudomy/; ./sudomy -rS -s shodan,virustotal,censys,SecurityTrails,Binaryedge -d $DOMAIN -o /bounty/$CLI/$DOMAIN
cat /bounty/$CLI/$DOMAIN/Sudomy-Output/$DOMAIN/subdomain.txt >> /bounty/$CLI/sudomy-dns.txt
echo "[+] SUBFINDER $DOMAIN"
echo
subfinder -d $DOMAIN -o /bounty/$CLI/subfinder-dns.txt
echo "[+] CRT $DOMAIN"
echo
curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' >> /bounty/$CLI/crt-dns.txt

cat /bounty/$CLI/amass-dns.txt | anew /bounty/$CLI/subdomains.txt
cat /bounty/$CLI/crt-dns.txt /bounty/$CLI/assetfinder-dns.txt /bounty/$CLI/subfinder-dns.txt /bounty/$CLI/sudomy-dns.txt | anew /bounty/$CLI/subdomains.txt
