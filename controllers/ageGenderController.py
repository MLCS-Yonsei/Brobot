import sys
sys.path.insert(0, './bin/age_gender')
from age_gender_main import *
import tensorflow as tf

import multiprocessing
from threading import Thread

def gender_estimate(fq,gq):
    class_type = 'gender'

    config = tf.ConfigProto(allow_soft_placement=True,device_count={'CPU': 1})
    # config.gpu_options.allow_growth = True
    with tf.Session(config=config) as sess:
        GENDER_LIST =['M','F']
        AGE_LIST = ['(0, 3)','(4, 7)','(8, 13)','(14, 20)','(21, 33)','(34, 45)','(46, 59)','(60, 100)']

        label_list = AGE_LIST if class_type == 'age' else GENDER_LIST
        nlabels = len(label_list)

        model_fn = select_model('default')

        with tf.device('/cpu:1'):
            
            images = tf.placeholder(tf.float32, [None, RESIZE_FINAL, RESIZE_FINAL, 3])
            logits = model_fn(nlabels, images, 1, False)
            init = tf.global_variables_initializer()
            
            requested_step = None # FLAGS.requested_step if FLAGS.requested_step else None
        
            if class_type == 'gender':
                checkpoint_path = '%s' % ('./bin/age_gender/2_GEN_fold/gen_test_fold_is_WKFD/run-22588')
            else:
                checkpoint_path = '%s' % ('./bin/age_gender/1_AGE_fold/age_test_fold_is_WKFD/run-12870')

            model_checkpoint_path, global_step = get_checkpoint(checkpoint_path, requested_step, 'checkpoint')
            
            
            saver = tf.train.Saver()
            saver.restore(sess, model_checkpoint_path)

            softmax_output = tf.nn.softmax(logits)

            coder = ImageCoder()

            while True:
                files = []
                print("Wait for face data")
                [face_files, img, tgtdir] = fq.get()
                print("Face data RCVD!")
                files += face_files

                if (len(files)>0):
                    best_choices = age_gender_main(sess, img, label_list, softmax_output, coder, images, [files[0]], tgtdir)
                    
                    gq.put(parse_estimation(best_choices))
                else:
                    gq.put(False)

def age_estimate(fq,aq):
    class_type = 'age'

    config = tf.ConfigProto(allow_soft_placement=True,device_count={'CPU': 1})
    # config.gpu_options.allow_growth = True
    with tf.Session(config=config) as sess:
        GENDER_LIST =['M','F']
        AGE_LIST = ['(0, 3)','(4, 7)','(8, 13)','(14, 20)','(21, 33)','(34, 45)','(46, 59)','(60, 100)']

        label_list = AGE_LIST if class_type == 'age' else GENDER_LIST
        nlabels = len(label_list)

        model_fn = select_model('default')

        with tf.device('/cpu:1'):
            
            images = tf.placeholder(tf.float32, [None, RESIZE_FINAL, RESIZE_FINAL, 3])
            logits = model_fn(nlabels, images, 1, False)
            init = tf.global_variables_initializer()
            
            requested_step = None # FLAGS.requested_step if FLAGS.requested_step else None
        
            if class_type == 'gender':
                checkpoint_path = '%s' % ('./bin/age_gender/2_GEN_fold/gen_test_fold_is_WKFD/run-22588')
            else:
                checkpoint_path = '%s' % ('./bin/age_gender/1_AGE_fold/age_test_fold_is_WKFD/run-12870')

            model_checkpoint_path, global_step = get_checkpoint(checkpoint_path, requested_step, 'checkpoint')
            
            
            saver = tf.train.Saver()
            saver.restore(sess, model_checkpoint_path)

            softmax_output = tf.nn.softmax(logits)

            coder = ImageCoder()

            while True:
                files = []
                print("Wait for face data")
                [face_files, img, tgtdir] = fq.get()
                print("Face data RCVD!")
                files += face_files

                if (len(files)>0):
                    best_choices = age_gender_main(sess, img, label_list, softmax_output, coder, images, [files[0]], tgtdir)
                    
                    aq.put(parse_estimation(best_choices))
                else:
                    aq.put(False)

def hooker_age_gender_estimating_sess(img, class_type, files, tgtdir):
    config = tf.ConfigProto(allow_soft_placement=True,device_count={'GPU': 0})
    config.gpu_options.allow_growth = True
    with tf.Session(config=config) as sess:
        GENDER_LIST =['M','F']
        AGE_LIST = ['(0, 3)','(4, 7)','(8, 13)','(14, 20)','(21, 33)','(34, 45)','(46, 59)','(60, 100)']

        label_list = AGE_LIST if class_type == 'age' else GENDER_LIST
        nlabels = len(label_list)

        model_fn = select_model('default')

        with tf.device('/cpu:0'):
            
            images = tf.placeholder(tf.float32, [None, RESIZE_FINAL, RESIZE_FINAL, 3])
            logits = model_fn(nlabels, images, 1, False)
            init = tf.global_variables_initializer()
            
            requested_step = None # FLAGS.requested_step if FLAGS.requested_step else None
        
            if class_type == 'gender':
                checkpoint_path = '%s' % ('./bin/age_gender/2_GEN_fold/gen_test_fold_is_WKFD/run-22588')
            else:
                checkpoint_path = '%s' % ('./bin/age_gender/1_AGE_fold/age_test_fold_is_WKFD/run-12870')

            model_checkpoint_path, global_step = get_checkpoint(checkpoint_path, requested_step, 'checkpoint')
            
            saver = tf.train.Saver()
            saver.restore(sess, model_checkpoint_path)
                        
            softmax_output = tf.nn.softmax(logits)

            coder = ImageCoder()

            if (len(files)>0):
                best_choices = age_gender_main(sess, img, label_list, softmax_output, coder, images, files, tgtdir)
                parse_estimation(best_choices)

            while True:
                time.sleep(0.1)

                if gv.hooker_working == False:
                    files = []
                    face_files, img, tgtdir = hooker_capture()
                    files += face_files

                    if (len(files)>0):
                        best_choices = age_gender_main(sess, img, label_list, softmax_output, coder, images, [files[0]], tgtdir)
                        parse_estimation(best_choices)


def robot_controller(position):
    gv.hooker_position = position
    # 로봇 이동 코드 삽입
    gv.hooker_working = True

def parse_estimation(result):
    if len(result[0][0]) == 1:
        return result[0][0]
    else:
        _age = eval(result[0][0])[0]
        
        if _age<20:
            _age_type = 0
        elif _age>=20 and _age<45:
            _age_type = 1
        elif _age>=45:
            _age_type = 2

        return _age_type
    
def hooker_capture():
    cap = cv2.VideoCapture(1)
    
    _, img = cap.read()
    height, width = img.shape[:2]

    w1 = int(width/2)
    w2 = int(width)
    h1 = int(height/2)
    h2 = int(height)
    quadrant = 0
    if quadrant == 1:
        img = img[0:h1,w1:w2]
    elif quadrant == 2:
        img = img[int(height/2):height,0:int(width/2)]
    elif quadrant == 3:
        img = img[int(height/2):height,0:int(width/2)]
    elif quadrant == 4:
        img = img[0:int(height/2),int(width/2):width]


    ch1 = int(0.1 * height)
    ch2 = int(0.8 * height)
    cw1 = int(0.2 * width)
    cw2 = int(0.8 * width)

    cc1 = int(0.2 * (cw2 - cw1))
    cc2 = int((1 - 0.3) * (cw2 - cw1))
    img = img[ch1:ch2,cw1:cw2]

    files = []
    face_detect = face_detection_model('dlib', './bin/age_gender/Model/shape_predictor_68_face_landmarks.dat')
    faces, face_files, rectangles, tgtdir = face_detect.run(img)
    if len(faces) > 0:
        btm = faces[0].bottom()
        x_center = faces[0].left() + int((faces[0].right() - faces[0].left())/2)

        pts0 = np.float32([[btm],[x_center],[1]])
        pts1 = np.float32([[cc1,0],[0,ch2-ch1],[cc2,0],[cw2-cw1,ch2-ch1]])
        pts2 = np.float32([[0,0],[0,ch2-ch1],[cw2-cw1,0],[cw2-cw1,ch2-ch1]])

        M = cv2.getPerspectiveTransform(pts1, pts2)

        # 대상체로 이동
        pts3 = np.matmul(M,pts0)

        robot_controller(pts3[0][0]/(cw2-cw1))

    return face_files, img, tgtdir

def hooker():
    files = []
    face_files, img, tgtdir = hooker_capture()
    files += face_files

    threads = []
    for _c in ['gender','age']:
        _t = Thread(target=hooker_age_gender_estimating_sess, args=(img,_c, [files[0]], tgtdir))
        _t.start()
        threads.append(_t)

    for _t in threads:
        _t.join()

def hooker_start():
    print("Starting hooker")
    mp = multiprocessing.Process(target=hooker, args=())
    mp.start()
    
    return mp

def hooker_stop():
    print("Stopping hooker")
    if gv.hooker is not None:
        gv.hooker.terminate()
        gv.hooker.join() 
        gv.hooker = None

    # Update App Status
    app_status = checkAppStatus()
    app_status["hooker"] = False
    updateAppStatus(app_status)
