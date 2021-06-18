#!/bin/bash

CLI=$1

echo "[+][+] Enumerando Subdominios e URLS"
echo
for d in $(cat /bounty/$CLI/dominios.txt);do
        /bounty/enum_subdomain.sh $d $CLI
        /bounty/enum_url.sh $d $CLI
done

echo "[+][+] URLS Crawler"
echo
/bounty/enum_url_crawler.sh $CLI

echo "[+][+] URLS Param"
echo
/bounty/enum_param.sh $CLI

echo "[+][+] Testando XSS"
echo
/bounty/enum_xss.sh $CLI
