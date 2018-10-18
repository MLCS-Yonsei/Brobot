import sys
import os
import numpy as np
import tensorflow as tf

from PIL import Image
from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as vis_util

from bin.sort.sort import *
from bin.deep_sort.multiple import Deep_Sort
from bin.color_extractor.color_extractor import ImageToColor

import atexit

import time

import socket
import redis
r = redis.StrictRedis(host='redis.hwanmoo.kr', port=6379, db=0)


CWD_PATH = os.getcwd()

# Path to frozen detection graph. This is the actual model that is used for the object detection.
MODEL_NAME = 'ssd_mobilenet_v1_coco_2017_11_17'
PATH_TO_CKPT = os.path.join(CWD_PATH, 'object_detection', MODEL_NAME, 'frozen_inference_graph.pb')

# List of the strings that is used to add correct label for each box.
PATH_TO_LABELS = os.path.join(CWD_PATH, 'object_detection', 'data', 'mscoco_label_map.pbtxt')


NUM_CLASSES = 90

# Loading label map
label_map = label_map_util.load_labelmap(PATH_TO_LABELS)
categories = label_map_util.convert_label_map_to_categories(label_map, max_num_classes=NUM_CLASSES,
                                                            use_display_name=True)
category_index = label_map_util.create_category_index(categories)

def detect_objects(image_np, sess, detection_graph, mot_tracker, deep_tracker, r, img_to_color):
    # Expand dimensions since the model expects images to have shape: [1, None, None, 3]
    image_np_expanded = np.expand_dims(image_np, axis=0)
    image_tensor = detection_graph.get_tensor_by_name('image_tensor:0')

    # Each box represents a part of the image where a particular object was detected.
    boxes = detection_graph.get_tensor_by_name('detection_boxes:0')

    # Each score represent how level of confidence for each of the objects.
    # Score is shown on the result image, together with the class label.
    scores = detection_graph.get_tensor_by_name('detection_scores:0')
    classes = detection_graph.get_tensor_by_name('detection_classes:0')
    num_detections = detection_graph.get_tensor_by_name('num_detections:0')

    # Actual detection.
    (boxes, scores, classes, num_detections) = sess.run(
        [boxes, scores, classes, num_detections],
        feed_dict={image_tensor: image_np_expanded})
    
    img_height = image_np.shape[0]
    img_width = image_np.shape[1]

    min_score_thresh = 0.5

    track_boxes = []
    track_objs = []
    person_ids = []
    _person_ids = [i for i, e in enumerate(classes[0]) if e == 1]
    person_boxes = []
    person_scores = []
    person_classes = []
    for p_id in _person_ids:
        if scores[0][p_id] > min_score_thresh:
            person_ids.append(p_id)
            person_box = boxes[0][p_id]
            person_boxes.append(person_box)

            person_classes.append(1)

            person_score = scores[0][p_id]
            person_scores.append(person_score)
            _track_box = [person_box[1]*img_width, person_box[0]*img_height, person_box[3]*img_width, person_box[2]*img_height]

            track_boxes.append(_track_box)

            _track_obj = {
                'topleft': {
                    'x': person_box[1]*img_width,
                    'y': person_box[0]*img_height
                },
                'bottomright': {
                    'x': person_box[3]*img_width,
                    'y': person_box[2]*img_height
                },
                'confidence': person_score
            }
            track_objs.append(_track_obj)
    
    # trackers = mot_tracker.update(np.asarray(track_boxes))
    trackers = deep_tracker.track(track_objs, image_np)
    # print("trackers: ", trackers)
    # print("person ids", person_ids)
    if len(trackers) > 0 and len(trackers) == len(person_ids):
        # 북서남동
        print("person ids", person_ids)
        # print(person_tracker[4])
        def crop_img(img,box):
            y,x,d = img.shape
            startx = int(x*box[0])
            starty = int(y*box[1])
            endx = int(x*box[3])
            endy = int(y*box[2])

            return img[starty:endy,startx:endx]

        person_attrs = []
        for idx, person_id in enumerate(person_ids):
            try:
                person_box = person_boxes[idx]

                person_img = crop_img(image_np,person_box)
                # c = img_to_color.get(person_img)
            except:
                pass
            c = 'NA'

            person_attr = {
                'age':1,
                'gender':1,
                'color':c
            }
            
            person_attrs.append(person_attr)

        # start_time = time.time()

        # elapsed_time = time.time() - start_time
        # print("ET",elapsed_time)
        
        # for r in results:
        #     person_attr[r['flag']] = r['value']
        

        # override boxes
        person_boxes = np.asarray(person_boxes)
        person_scores = np.asarray(person_scores)
        person_classes = np.asarray(person_classes)
        print("tracker",trackers)
        # if len(trackers) == len(person_ids):
        # print(person_boxes.shape, person_scores.shape, person_classes.shape, trackers.shape)
        # Visualization of the results of a detection.
        vis_util.visualize_boxes_and_labels_on_image_array(
            image_np,
            person_boxes,
            person_classes,
            person_scores,
            trackers,
            person_attrs,
            category_index,
            use_normalized_coordinates=True,
            line_thickness=3,
            min_score_thresh=min_score_thresh)

    return image_np, trackers

# First test on images
PATH_TO_TEST_IMAGES_DIR = 'object_detection/test_images'
TEST_IMAGE_PATHS = [ os.path.join(PATH_TO_TEST_IMAGES_DIR, 'image{}.jpg'.format(i)) for i in range(1, 3) ]

# Size, in inches, of the output images.
IMAGE_SIZE = (12, 8)

def load_image_into_numpy_array(image):
  (im_width, im_height) = image.size
  return np.array(image.getdata()).reshape(
      (im_height, im_width, 3)).astype(np.uint8)

detection_graph = tf.Graph()
with detection_graph.as_default():
    od_graph_def = tf.GraphDef()
    with tf.gfile.GFile(PATH_TO_CKPT, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')

import cv2
import time

CAM_ID = 1
cam = cv2.VideoCapture(CAM_ID)

if cam.isOpened() == False:
    print('Can\'t open the CAM(%d)' % (CAM_ID))
    exit()

cv2.namedWindow('Cam')
prevTime = 0


# ips = eval(r.hget('subscribers','list'))
# if ips is None:
#     ips = [local_ip]
# else:
#     if local_ip not in ips:
#         ips.append(local_ip)

# r.hset('subscribers','list',ips)
# r.hset('subscribers',local_ip,True)

# def unset_redis_at_exit(r,local_ip):
#     r.hset('subscribers',local_ip,False)

# atexit.register(unset_redis_at_exit,r=r,local_ip=local_ip)

import socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(("192.168.0.23", 8250))

with detection_graph.as_default():
    with tf.Session(graph=detection_graph) as sess:
        # Load modules
        mot_tracker = Sort() 
        deep_tracker = Deep_Sort()

        npz = np.load('bin/color_extractor/color_names.npz')
        img_to_color = ImageToColor(npz['samples'], npz['labels'])

        while (True):
            ret, frame = cam.read()
            
            # Detection
            image_process, track_results = detect_objects(frame, sess, detection_graph, mot_tracker, deep_tracker, r, img_to_color)

            if len(track_results) > 0:
                _s = 0
                target = None
                for _t in track_results:
                    _size = _t['bottomright']['x'] - _t['topleft']['x']

                    if _size > _s:
                        target = _t
                        _s = _size

                if target is not None:
                    _c = frame.shape[1] / 2
                    center = ( target['bottomright']['x'] + target['topleft']['x'] ) / 2
                    '''
                    1. 타겟 크기가 일정 크기보다 크면 좌우를 찾기 힘들기 때문에 일정 크기 이상일 시 정지하는게 좋아보임.
                    2. 타켓 센터와 뷰 센터의 거리가 멀면 더 빠르게 이동할 것
                    3. 바운더리 바깥에서 접근할 시(센서값으로 바운더리인지 확인), 처음부터 빠르게 이동할 필요가 있음.
                    '''
                    if _c >= center * 1.12:
                        # 0012STX101111ETX
                        
                        data = '0012STX011011ETX'

                        if data != '':
                            client_socket.send(data.encode())
                        
                    elif _c <= center * 0.88:
                        data = '0012STX101011ETX'

                        if data != '':
                            client_socket.send(data.encode())

                    else:
                        data = '0012STX110000ETX'

                        if data != '':
                            client_socket.send(data.encode())

                    print(data)
                    data = ''



            curTime = time.time()
            sec = curTime - prevTime
            prevTime = curTime
            fps = 1 / (sec)

            str = "FPS : %0.1f" % fps
            str2 = "Testing . . ."
            cv2.putText(frame, str, (5, 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0))
            cv2.putText(frame, str2, (100, 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0))
            cv2.imshow('Cam', cv2.resize(frame, (1300, 800)))

            if cv2.waitKey(1) & 0xFF == ord('q'):
                cam.release()
                cv2.destroyWindow('Cam')
                break

            
            
            # plt.figure(figsize=IMAGE_SIZE)
            # plt.imshow(image_process)
            # plt.show()

        process_gender.join()
        process_age.join()