import sys
import os
import numpy as np
import tensorflow as tf
from matplotlib import pyplot as plt
from PIL import Image
from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as vis_util

from sort.sort import *
from bin.color_extractor.color_extractor import ImageToColor

from controllers.ageGenderController import *

from multiprocessing import Process, Queue, Pipe

sys.path.insert(0, './bin/age_gender')
from age_gender_main import *

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

def detect_objects(image_np, sess, detection_graph, mot_tracker, window_size):
    global right_clicks

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

    trackers = mot_tracker.update(boxes[0])
    
    person_ids = [i for i, e in enumerate(classes[0]) if e == 1]

    boxes = [x for i,x in enumerate(boxes[0]) if i in person_ids]
    scores = [x for i,x in enumerate(scores[0]) if i in person_ids]
    if len(person_ids) > 0:
        for idx, person_id in enumerate(person_ids):
            selected_person_id = person_id
            
            person_box = boxes[idx] # NWSE
            person_score = scores[idx]
            # person_tracker = trackers[selected_person_id]

            person_attr = {
                'age':1,
                'gender':1,
                'color':1
            }

            def get_bottom_center(person_box, window_size):
                b = person_box[2] * window_size[1]
                l = person_box[1] * window_size[0]
                r = person_box[3] * window_size[0]

                c = (r - l) / 2 + l
                
                return (int(c), int(b))

            def get_side(a,b,c):
                print(a,b,c)
                if c[1] >= min(a[1],b[1]) and c[1] <= max(a[1],b[1]):
                    # bc is between a and b
                    cross_product = (b[0] - a[0])*(c[1] - a[1]) - (b[1] - a[1])*(c[0] - a[0])
                    if cross_product < 0:
                        # bc is on the left
                        return True
                    else: 
                        return False
                else:
                    return False

            person_bc = get_bottom_center(person_box, window_size)

            if len(right_clicks) == 2:
                side = get_side(right_clicks[0],right_clicks[1],person_bc)
                print(side)     

        # override boxes
        # boxes = np.expand_dims(person_box, axis=0)
        # classes = [1]
        # scores = np.expand_dims(person_score, axis=0)
        # trackers = np.expand_dims(person_tracker, axis=0)
        # person_attr = [person_attr]

        # Visualization of the results of a detection.
        vis_util.visualize_boxes_and_labels_on_image_array(
            image_np,
            np.squeeze(boxes),
            np.squeeze(classes),
            np.squeeze(scores),
            None,
            None,
            category_index,
            use_normalized_coordinates=True,
            line_thickness=3)

    return image_np

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


import time

from multiprocessing import Process, Queue
import cv2

import numpy as np

right_clicks = []
# mouse callback function
def mouse_callback(event, x, y, flags, params):
    #right-click event value is 2
    if event == 2:
        global right_clicks

        if len(right_clicks) < 2:
            right_clicks.append([x, y])
        else:
            right_clicks = [[x,y]]

        print(right_clicks)
        

# Init Multi Cams
CAM_ID = 0

cam = cv2.VideoCapture(int(CAM_ID))

window_name = 'Cam'+str(CAM_ID)
cv2.namedWindow(window_name)
cv2.setMouseCallback(window_name,mouse_callback)

prevTime = 0
window_size = (1300, 800)

with detection_graph.as_default():
    with tf.Session(graph=detection_graph) as sess:
        mot_tracker = Sort() 
        while (True):
            ret, frame = cam.read()
            
            if frame is not None:
                # Detection
                image_process = detect_objects(frame, sess, detection_graph, mot_tracker, window_size)

                curTime = time.time()
                sec = curTime - prevTime
                prevTime = curTime
                fps = 1 / (sec)

                fps_str = "FPS : %0.1f" % fps

                cv2.putText(frame, fps_str, (5, 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0))

                cv2.imshow(window_name,cv2.resize(frame, window_size))

                cv2.line(frame, pt1=(5, 20), pt2=(100, 10), color=(255, 0, 0), thickness=5, lineType=8, shift=0)
                
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    cam.release()
                    cv2.destroyWindow(window_name)
                    break

cv2.destroyAllWindows()