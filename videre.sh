#!/usr/bin/bash

VERD="\033[0;32m"
FIM="\033[0;00m"

echo -e "  + Looking for IP history for ${VERD}$1${FIM}\n"

curl -s "https://viewdns.info/iphistory/?domain=$1" -H "User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Mobile Safari/537.36" --compressed > "$1".tmp
echo -e "  + ${VERD}DATE        ${FIM}|   ${VERD}IP                  ${FIM}| ${VERD}OWNER & LOCATION${FIM}"
cat "$1".tmp | sed ':a;N;$!ba;s/\n/ /g' | sed 's/<table border="1">/\nIPHISTORY/g' | sed 's/<\/table>/\n/g' | grep ^IPHISTORY | sed 's/<tr><td>/\n/g' | sed 's/\r//' | grep ^[0-9] | sed 's/<\/td><td>/|/g' | sed 's/<\/td><td align="center">/|/g' | sed 's/<\/td><\/tr>//g' | awk -F '|' '{print "  - "$4" \t|  "$1" \t|  "$3"("$2")"}'
