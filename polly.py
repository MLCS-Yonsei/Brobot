from boto3 import Session
from botocore.exceptions import BotoCoreError, ClientError
from contextlib import closing
import os
import sys
import subprocess
from tempfile import gettempdir

from mutagen.mp3 import MP3
from math import ceil
from time import sleep

import json
import datetime
with open('./AWS_key.json') as f:
    aws_key = json.load(f)

def play_with_polly(text):
    # Create a client using the credentials and region defined in the [adminuser]
    # section of the AWS credentials file (~/.aws/credentials).
    settings = {
        'AWS_SERVER_PUBLIC_KEY':aws_key['AWS_SERVER_PUBLIC_KEY'],
        'AWS_SERVER_SECRET_KEY':aws_key['AWS_SERVER_SECRET_KEY']
    }

    session = Session(
        aws_access_key_id=settings['AWS_SERVER_PUBLIC_KEY'],
        aws_secret_access_key=settings['AWS_SERVER_SECRET_KEY'],
    )

    polly = session.client("polly", region_name='ap-northeast-2')

    try:
        # Request speech synthesis
        response = polly.synthesize_speech(Text=text, OutputFormat="mp3",
                                            VoiceId="Seoyeon")
    except (BotoCoreError, ClientError) as error:
        # The service returned an error, exit gracefully
        print(error)
        sys.exit(-1)

    # Access the audio stream from the response
    if "AudioStream" in response:
        # Note: Closing the stream is important as the service throttles on the
        # number of parallel connections. Here we are using contextlib.closing to
        # ensure the close method of the stream object will be called automatically
        # at the end of the with statement's scope.
        with closing(response["AudioStream"]) as stream:
            output = os.path.join(gettempdir(), str(datetime.datetime.now()) + "speech.mp3")
            
            try:
                # Open a file for writing the output as a binary stream
                with open(output, "wb") as file:
                    file.write(stream.read())
            except IOError as error:
                # Could not write to file, exit gracefully
                print(error)
                # sys.exit(-1)

    else:
        # The response didn't contain audio data, exit gracefully
        print("Could not stream audio")
        sys.exit(-1)

    # Play the audio using the platform's default player
    if sys.platform == "win32":
        os.startfile(output)

    else:
        # the following works on Mac and Linux. (Darwin = mac, xdg-open = linux).
        opener = "open" if sys.platform == "darwin" else "xdg-open"
        subprocess.call([opener, output])

    # audio = MP3(output)
    # _play_time = ceil(audio.info.length)
    # sleep(_play_time)

if __name__ == '__main__':
    r = play_with_polly("빨간 옷이 참 잘어울리시네요")
    print("Play time : ", r)
