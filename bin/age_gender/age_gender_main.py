from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from datetime import datetime
import math
import time
import sys
from data import inputs
import numpy as np
import tensorflow as tf
from model import select_model, get_checkpoint
from ag_utils import *
import os
import json
import csv
import subprocess as sp

RESIZE_FINAL = 227
GENDER_LIST =['M','F']
AGE_LIST = ['(0, 3)','(4, 7)','(8, 13)','(14, 20)','(21, 33)','(34, 45)','(46, 59)','(60, 100)']
MAX_BATCH_SZ = 128

tf.app.flags.DEFINE_string('model_dir', './bin/age_gender/2_GEN_fold/gen_test_fold_is_WKFD/run-22588',
                           'Model directory (where training data lives)')

tf.app.flags.DEFINE_string('class_type', 'gender',
                           'Classification type (age|gender)')


tf.app.flags.DEFINE_string('device_id', '/cpu:0',
                           'What processing unit to execute inference on')

tf.app.flags.DEFINE_string('filename', 'frontal-face-1.jpg',
                           'File (Image) or File list (Text/No header TSV) to process')

tf.app.flags.DEFINE_string('target', '',
                           'CSV file containing the filename processed along with best guess and score')

tf.app.flags.DEFINE_string('checkpoint', 'checkpoint',
                          'Checkpoint basename')

tf.app.flags.DEFINE_string('model_type', 'default',
                           'Type of convnet')

tf.app.flags.DEFINE_string('requested_step', '', 'Within the model directory, a requested step to restore e.g., 9000')

tf.app.flags.DEFINE_boolean('single_look', False, 'single look at the image or multiple crops')

tf.app.flags.DEFINE_string('face_detection_model', './bin/age_gender/Model/shape_predictor_68_face_landmarks.dat', 'Do frontal face detection with model specified')

tf.app.flags.DEFINE_string('face_detection_type', 'dlib', 'Face detection model type (yolo_tiny|cascade)')

FLAGS = tf.app.flags.FLAGS

def one_of(fname, types):
    return any([fname.endswith('.' + ty) for ty in types])

def resolve_file(fname):
    if os.path.exists(fname): return fname
    for suffix in ('.jpg', '.png', '.JPG', '.PNG', '.jpeg'):
        cand = fname + suffix
        if os.path.exists(cand):
            return cand
    return None


def classify_many_single_crop(sess, label_list, softmax_output, coder, images, image_files, writer):
    try:
        num_batches = math.ceil(len(image_files) / MAX_BATCH_SZ)
        pg = ProgressBar(num_batches)
        for j in range(num_batches):
            start_offset = j * MAX_BATCH_SZ
            end_offset = min((j + 1) * MAX_BATCH_SZ, len(image_files))
            
            batch_image_files = image_files[start_offset:end_offset]
            print(start_offset, end_offset, len(batch_image_files))
            image_batch = make_multi_image_batch(batch_image_files, coder)
            batch_results = sess.run(softmax_output, feed_dict={images:image_batch.eval()})
            batch_sz = batch_results.shape[0]
            for i in range(batch_sz):
                output_i = batch_results[i]
                best_i = np.argmax(output_i)
                best_choice = (label_list[best_i], output_i[best_i])
                print('Guess @ 1 %s, prob = %.2f' % best_choice)
                if writer is not None:
                    f = batch_image_files[i]
                    writer.writerow((f, best_choice[0], '%.2f' % best_choice[1]))
            pg.update()
        pg.done()
    except Exception as e:
        print(e)
        print('Failed to run all images')

def classify_one_multi_crop(sess, label_list, softmax_output, coder, images, image_file, writer):
    try:
        print('Running file %s' % image_file)
        image_batch = make_multi_crop_batch(image_file, coder)

        batch_results = sess.run(softmax_output, feed_dict={images:image_batch.eval()})
        output = batch_results[0]
        batch_sz = batch_results.shape[0]
    
        for i in range(1, batch_sz):
            output = output + batch_results[i]
        
        output /= batch_sz
        best = np.argmax(output)
        best_choice = (label_list[best], output[best])
        print('Guess @ 1 %s, prob = %.2f' % best_choice)
    
        nlabels = len(label_list)
        if nlabels > 2:
            output[best] = 0
            second_best = np.argmax(output)
            print('Guess @ 2 %s, prob = %.2f' % (label_list[second_best], output[second_best]))

        if writer is not None:
            writer.writerow((image_file, best_choice[0], '%.2f' % best_choice[1]))

        return best_choice
    except Exception as e:
        print(e)
        print('Failed to run image %s ' % image_file)

def list_images(srcfile):
    with open(srcfile, 'r') as csvfile:
        delim = ',' if srcfile.endswith('.csv') else '\t'
        reader = csv.reader(csvfile, delimiter=delim)
        if srcfile.endswith('.csv') or srcfile.endswith('.tsv'):
            print('skipping header')
            _ = next(reader)
        
        return [row[0] for row in reader]

def age_gender_main(sess, img, label_list, softmax_output, coder, images, files, tgtdir):  # pylint: disable=unused-argument
    
    start_time = time.time()
    best_choices = []
    # Support a batch mode if no face detection model
    # if len(files) == 0:
    #     if (os.path.isdir(FLAGS.filename)):
    #         for relpath in os.listdir(FLAGS.filename):
    #             abspath = os.path.join(FLAGS.filename, relpath)
                
    #             if os.path.isfile(abspath) and any([abspath.endswith('.' + ty) for ty in ('jpg', 'png', 'JPG', 'PNG', 'jpeg')]):
    #                 print(abspath)
    #                 files.append(abspath)
    #     else:
    #         files.append(FLAGS.filename)
    #         # If it happens to be a list file, read the list and clobber the files
    #         if any([FLAGS.filename.endswith('.' + ty) for ty in ('csv', 'tsv', 'txt')]):
    #             files = list_images(FLAGS.filename)
    if len(files) != 0: 

        writer = None
        output = None

        image_files = list(filter(lambda x: x is not None, [resolve_file(f) for f in files]))
        

        if FLAGS.single_look:
            classify_many_single_crop(sess, label_list, softmax_output, coder, images, image_files, writer)

        else:
            for image_file in image_files:
                best_choices.append(classify_one_multi_crop(sess, label_list, softmax_output, coder, images, image_file, writer))

        if output is not None:
            output.close()
        
        elapsed_time = time.time() - start_time
        print(elapsed_time)
        # time.sleep(3)
                

    if tgtdir:
        print("tgtdir", tgtdir)

    return best_choices
        
if __name__ == '__main__':
    tf.app.run()
