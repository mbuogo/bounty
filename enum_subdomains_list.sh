#!/bin/bash

CLI=$1
DOMAIN=$2
log="/bounty/queue/subdomain.log"
rm -rf $CLI/urls.txt
rm -rf $CLI/subdomains.txt

echo "[+][-] Assetfinder -  $DOMAIN"
echo
echo "assetfinder -subs-only $DOMAIN >> /bounty/$CLI/temp/assetfinder.txt" >> $log

echo "[+][-] Crt -  $DOMAIN"
echo
echo "curl -s 'https://crt.sh/?q=%25.$DOMAIN&output=json' | jq -r '.[].name_value' | sed 's/\*\.//g' >> /bounty/$CLI/temp/crt.txt" >> $log

echo "[+][-] Subfinder -  $DOMAIN"
echo
echo "subfinder -d $DOMAIN -silent >> /bounty/$CLI/temp/subfinder.txt" >> $log

echo "[+][-] Sublist3r -  $DOMAIN"
echo
echo "sleep 30; python3 /opt/Sublist3r/sublist3r.py -d $DOMAIN >> /bounty/$CLI/temp/sublist3r.txt " >> $log

echo "[+][-] Gh -  $DOMAIN"
echo
echo "cd /opt/github-search; python3 github-subdomains.py --token xxxxxx -d $DOMAIN | grep -v '>>>' >> /bounty/$CLI/temp/gh.txt " >> $log

echo "[+][-] Gobuster -  $DOMAIN"
echo
echo "gobuster dns -d $DOMAIN -w /wordlists/dns-Jhaddix.txt -t 1500 --delay 50ms >> /bounty/$CLI/temp/gouster.txt" >> $log

echo "[+][-] Sudomy -  $DOMAIN"
echo
echo "sleep 45; cd /opt/Sudomy/; ./sudomy -rS -s shodan,virustotal,censys,SecurityTrails,Binaryedge -d $DOMAIN -o /bounty/$CLI/temp/" >> $log

#echo "[+][-] Amass -  $DOMAIN"
#echo
#echo "amass enum -brute -d $DOMAIN >> /bounty/$CLI/temp/amass.txt" > "$log$(uuidgen | cut -d"-" -f1)-amass-$DOMAIN"
