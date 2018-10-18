from flask import Flask, jsonify, request, send_from_directory, make_response
from flask_cors import CORS

import json
from urllib.parse import urlparse

import atexit
import datetime
import time
import os

from pydub import AudioSegment
from pydub.playback import play
import pyaudio

from time import time, sleep

from math import log, ceil, floor
from polly import play_with_polly

dir = os.path.dirname(os.path.abspath(__file__))

app = Flask(__name__)
CORS(app)

def create_app():
    return app

app = create_app()  

@app.route('/status', methods=['GET'])
def status():
    return jsonify({}), 200

def make_chunks(audio_segment, chunk_length):
    """
    Breaks an AudioSegment into chunks that are <chunk_length> milliseconds
    long.
    if chunk_length is 50 then you'll get a list of 50 millisecond long audio
    segments back (except the last one, which can be shorter)
    """
    number_of_chunks = ceil(len(audio_segment) / float(chunk_length))
    return [audio_segment[i * chunk_length:(i + 1) * chunk_length]
            for i in range(int(number_of_chunks))]

# @app.route('/play', methods=['GET'])
# def play():
#     req_path = request.args.get('path')
#     speaker = request.args.get('speaker')

#     if speaker == 'Jiwoong':
#         audio_format = pyaudio.paInt16
#     elif speaker == 'Ari':
#         audio_format = pyaudio.paInt32
#     else:
#         audio_format = pyaudio.paInt32

#     # file_path = os.path.join(dir,'bin')
#     file_path = dir
#     for p in req_path.split('/'):
#         if len(p) is not 0:
#             file_path = os.path.join(file_path,p)

#     seg = AudioSegment.from_wav(file_path)
#     p = pyaudio.PyAudio()
#     stream = p.open(format=audio_format,
#                     channels=seg.channels,
#                     rate=seg.frame_rate,
#                     output=True)

#     # break audio into half-second chunks (to allows keyboard interrupts)
#     for chunk in make_chunks(seg, 500):
#         stream.write(chunk._data)
    
#     stream.stop_stream()
#     stream.close()
#     p.terminate()

#     # time.sleep(seg.duration_seconds)

#     return jsonify({}), 200

@app.route('/polly', methods=['GET'])
def polly():
    text = request.args.get('text')
    print("RCVD Text:",text)
    try:
        r = play_with_polly(text)
        print(r)
        if r is not False:
            _v = AudioSegment.from_mp3(r)
            play(_v)
        return jsonify({'status':True}), 200
    except Exception as ex:
        return jsonify({'status':False,'msg':str(ex)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', threaded=True, port=3000)
