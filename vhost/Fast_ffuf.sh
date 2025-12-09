#!/bin/bash

function usage() {
    cat << EOF
Usage: $0 <DOMAIN> <WORDLIST> <URL> <FS FILTER_SIZE>

Options:
  -h, --help   Show this help message and exit

Description:
  This script creates a simple web server for capturing cookies.

Example:
  bash Fast_vhost.sh <DOMAIN> /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt <URL> <FS FILTER_SIZE>
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Check for four arguments, not two
if [[ $# -ne 4 ]]; then
    echo "Error: Missing Your Arguments. Check --help"
    usage
    exit 1
fi

DOMAIN="$1"
WORDLIST="$2"
URL="$3"
FS="$4"

ffuf -H "Host: FUZZ.$DOMAIN" -H "User-Agent: PenTesting" -c -w "$WORDLIST" -u "$URL" -fs "$FS"
