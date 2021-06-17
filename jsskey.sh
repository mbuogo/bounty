bola=$1

rm -rf /scripts/jskeys/$bola-parsejs.txt /scripts/jskeys/keyidentified-$bola.txt

echo "[+] BUSCANDO JS"
echo
cat /opt/Sudomy/$bola/Sudomy-Output/$bola/httprobe_subdomain.txt | cut -d "/" -f3 | /root/go/bin/waybackurls | grep -iE '\.js'| grep -ivE '\.json' >> /scripts/jskeys/$bola-js.txt
cat /opt/Sudomy/$bola/Sudomy-Output/$bola/httprobe_subdomain.txt | cut -d "/" -f3 | /root/go/bin/subjs >> /scripts/jskeys/$bola-js.txt
cat /scripts/jskeys/$bola-js.txt | sort -u >> /scripts/jskeys/$bola-parse.txt
cat /scripts/jskeys/$bola-parse.txt | /root/go/bin/anti-burl | awk {'print $4'} >> /scripts/jskeys/$bola-parsejs.txt

echo "[+] PARSE DOS JS"
echo
python3 /opt/JSScanner/JSScanner.py /scripts/jskeys/$bola-parsejs.txt /opt/JSScanner/regex.txt >> /scripts/jskeys/keyidentified-$bola.txt

cat /scripts/jskeys/keyidentified-$bola.txt | /root/go/bin/notify
