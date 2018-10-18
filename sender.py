import requests
import urllib
import sys

try:
    print("Connected to", sys.argv[1])
    url = "http://"+sys.argv[1]+":3000/polly"
except:
    print("Connected to 165.132.108.169")
    url = "http://165.132.108.169:3000/polly"
print("Type \"quit\" to quit.")
while True:
    
    text = input("Text input :")       
    if len(text) > 0:
        
        if text == 'quit':
            break
            
        querystring = {"text":text}

        headers = {
            'Cache-Control': "no-cache"
            }

        response = requests.request("GET", url, headers=headers, params=querystring)

