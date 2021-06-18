#!/bin/bash

CLI=$1
rm -rf /bounty/$CLI/url_param.txt

echo "[+] PARAMSPIDER" 
echo
for i in $(cat /bounty/$CLI/urls.txt);do
        /opt/ParamSpider/paramspider.py --domain $i -o /bounty/$CLI/url_spider.txt
        cat /bounty/$CLI/url_spider.txt | anew /bounty/$CLI/url_param.txt
done

rm -rf /bounty/$CLI/url_spider.txt
