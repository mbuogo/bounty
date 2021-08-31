#!/bin/bash

rm -rf /bounty/queue/
mkdir /bounty/queue/

#Limpa temp
for i in $(cat /bounty/clientes.txt);do
	rm -rf /bounty/$i/temp/*
done
echo -e '\e[33;1m[+] ENUMERACAO SUBDOMINIOS\e[m'
echo
for i in $(cat /bounty/clientes.txt);do
	for d in $(cat /bounty/$i/domains.txt);do
		/bounty/enum_subdomains_list.sh $i $d
	done
	#Processa Subdomains
	echo -e '\e[34;1m[+] PROCESSAMENTO SUBDOMINIOS\e[m'
	cat /bounty/queue/subdomain.log | parallel -u
	
	#Concatena Subdomains
	cat /bounty/$i/temp/*.txt | grep -v "microsoft" | anew /bounty/$i/subdomains.txt
	for d in $(cat /bounty/$i/domains.txt);do
		cat /bounty/$i/temp/Sudomy-Output/$d/subdomain.txt | anew /bounty/$i/subdomains.txt
		cat /bounty/$i/temp/Sudomy-Output/$d/httprobe_subdomain.txt | anew /bounty/$i/urls.txt	
        done
	
	#Limpa temp
	rm -rf /bounty/$i/temp/*
	
	#######################################################################
	echo -e '\e[33;1m[+] ENUMERACAO URL\e[m'
	echo
	/bounty/enum_urls_list.sh $i
	
	#Processa URLS
	echo -e '\e[34;1m[+] PROCESSAMENTO URLS\e[m'
	cat /bounty/queue/urls.log | parallel -u
	
	#Concatena URLS
	cat /bounty/$i/temp/*.txt | anew /bounty/$i/urls.txt
	
	#Limpa temp
	rm -rf /bounty/$i/temp/*
	
	#####################################################################
	echo -e '\e[33;1m[+] ENUMERACAO CRAWLER URL\e[m'
	echo
	/bounty/enum_crawler_urls_list.sh $i
	
	#Processa Crawler URL
	echo -e '\e[34;1m[+] PROCESSAMENTO CRAWLER URLS\e[m'
	cat /bounty/queue/crawler.log | parallel -u
	
	#Concatena URLS Crawler
	cat /bounty/$i/temp/*.txt | anew /bounty/$i/urls_crawler.txt
	
	#Limpa temp
	rm -rf /bounty/$i/temp/*
	
	######################################################################
	echo
	/bounty/enum_param_urls_list.sh $i

	#Processa Parametros PARAM URL
	echo -e '\e[34;1m[+] PROCESSAMENTO PARAM URLS\e[m'
	cat /bounty/queue/params.log | parallel -u
	#Concatena URLS Param
	cat /bounty/$i/temp/*.txt | anew /bounty/$i/urls_param.txt
	
	#Limpa temp
	rm -rf /bounty/$i/temp/*
	######################################################################
        echo -e '\e[33;1m[+] XSS\e[m'
        echo
        /bounty/xss_list.sh $i
        #Processa XSS URL
        echo -e '\e[34;1m[+] PROCESSAMENTO XSS\e[m'
        cat /bounty/queue/xss.log | parallel -u

        #Limpa temp
        rm -rf /bounty/$i/temp/*
	######################################################################
        echo -e '\e[33;1m[+] VULN\e[m'
	echo
	/bounty/vul_scan_list.sh $i
        #Processa VULN URL
        echo -e '\e[34;1m[+] PROCESSAMENTO VULN\e[m'
        cat /bounty/queue/vul.log | parallel -u
	######################################################################
	sleep 360
	rm -rf /bounty/queue/
	mkdir /bounty/queue/
done
