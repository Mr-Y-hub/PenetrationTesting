import requests
import sys
url = sys.argv[1]
r = requests.get(url)
result = r.text
print("[+] Result: {}".format(result))
print("\n")
