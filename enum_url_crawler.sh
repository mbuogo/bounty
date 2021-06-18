#!/bin/bash

CLI=$1
rm -rf /bounty/$CLI/url_crawler.txt

echo "[+] WAYBACKURL"
echo
cat /bounty/$CLI/urls.txt | waybackurls | anti-burl | awk '{print $4}' | anew /bounty/$CLI/url_crawler.txt

echo "[+] GAUPLUS"
echo
cat /bounty/$CLI/urls.txt | gauplus | anti-burl | awk '{print $4}' |anew /bounty/$CLI/url_crawler.txt
