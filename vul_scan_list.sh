#!/bin/bash

CLI=$1
log="/bounty/queue/vul.log"

echo "[+] NUCLEI"
echo
nuclei -ut
for url in $(cat /bounty/$CLI/urls.txt);do
	echo "nuclei -t /root/nuclei-templates/ -u $url --silent >> /bounty/$CLI/nuclei.txt" >> $log
done

for url2 in $(cat /bounty/$CLI/urls_especificas.txt);do
        echo "nuclei -t /root/nuclei-templates/ -u $url2 --silent >> /bounty/$CLI/nuclei.txt" >> $log
done

#for url3 in $(cat /bounty/$CLI/urls_crawler.txt);do
#        echo "nuclei -t /root/nuclei-templates/ -u $url3 --silent >> /bounty/$CLI/nuclei.txt" > "$log$(uuidgen | cut -d"-" -f1)-nuclei-$CLI"
#done
