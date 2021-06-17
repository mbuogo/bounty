#!/bin/bash

bola=$1

/opt/Sudomy/sudomy -rS -s shodan,virustotal,censys,SecurityTrails,Binaryedge -d $bola  -o $bola

for i in $(cat /opt/Sudomy/$bola/Sudomy-Output/$bola/httprobe_subdomain.txt); do
        echo "####################### - $i"
        /opt/ParamSpider/paramspider.py --domain "$i" -o /tmp/params$bola.txt
	cat /tmp/params$bola.txt | /root/go/bin/Gxss | /root/go/bin/dalfox pipe -S --skip-bav | /root/go/bin/notify
	sleep 2
	rm -rf /tmp/params$bola.txt
done
