import redis
import time
import numpy as np

import sys 

sys.path.insert(0, './bin/color_extractor')
from color_extractor import ImageToColor

from controllers.ageGenderController import *

from multiprocessing import Process, Queue, Pipe

sys.path.insert(0, './bin/age_gender')
from age_gender_main import *

r = redis.StrictRedis(host='redis.hwanmoo.kr', port=6379, db=0)

npz = np.load('bin/color_extractor/color_names.npz')
img_to_color = ImageToColor(npz['samples'], npz['labels'])

face_detect = face_detection_model('dlib', './bin/age_gender/Model/shape_predictor_68_face_landmarks.dat')


def get_color(q, img_q):
    while True:
        img = img_q.get()
        c = img_to_color.get(img)
        q.put({"flag":"color","value":c})
        # print("COlor",c)


def detect_face(q, img_q, face_detect, face_queue, gender_queue, age_queue):
    while True:
        files = []

        img = img_q.get()
        
        faces, face_files, rectangles, tgtdir = face_detect.run(img)
        face_queue.put([face_files, img, tgtdir])
        face_queue.put([face_files, img, tgtdir])

        person_gender = gender_queue.get()
        person_age = age_queue.get()
        # print("gender rcvd",person_gender)
        # print("Age rcvd",person_age)

        q.put({"flag":"gender","value":person_gender})
        q.put({"flag":"age","value":person_age})


img_queue = Queue()

face_queue = Queue()
gender_queue = Queue()
age_queue = Queue()

q = Queue()
procs = []

process_color = Process(target=get_color, args=(q, img_queue,))
procs.append(process_color)

process_face = Process(target=detect_face, args=(q, img_queue, face_detect, face_queue, gender_queue, age_queue))
procs.append(process_face)

process_gender = Process(target=gender_estimate, args=(face_queue,gender_queue))
procs.append(process_gender)

process_age = Process(target=age_estimate, args=(face_queue,age_queue))
procs.append(process_age)

for proc in procs:
    proc.start()

print("START")
while True:
    ips = eval(r.hget('subscribers','list'))

    if ips is not None:
        for ip in ips:
            status = eval(r.hget('subscribers',ip))
            
            if status:
                img_shape = r.hget('person_images_shape',ip)
                if img_shape is not None:
                    start_time = time.time()
                    img_bytes = r.hget('person_images',ip)

                    r.hdel('person_images_shape',ip)
                    r.hdel('person_images',ip)
                    r.hdel('person_attr',ip)

                    frame_frombytes = np.frombuffer(img_bytes, dtype=np.uint8).reshape(eval(img_shape))
                    
                    img_queue.put(frame_frombytes)
                    img_queue.put(frame_frombytes)

                    results = []

                    results.append(q.get())
                    results.append(q.get())
                    results.append(q.get())

                    # print(results)
                    r.hset('person_attr',ip,results)
                    elapsed_time = time.time() - start_time
                    print("ET",elapsed_time)
            
            if status == False:
                ips.remove(ip)
    else:
        time.sleep(0.5)