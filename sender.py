import requests
import sys
from threading import Thread
from time import sleep



class PollySender():
    def __init__(self):
        self.playing = False
        self._t = None

    def send_request(self, ip, text):
        url = "http://"+ip+":3000/polly"
        querystring = {"text":text}

        headers = {
            'Cache-Control': "no-cache"
            }

        response = requests.request("GET", url, headers=headers, params=querystring)

        sleep(4)
        self.playing = False
        exit(0)

    def send(self, ip, text):
        if self.playing == False:
            self.playing = True
            self._t = Thread(target = self.send_request, args = (ip,text, ))
            self._t.start()


if __name__=='__main__':
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