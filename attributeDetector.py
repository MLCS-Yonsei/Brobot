from controllers.ageGenderController import *
sys.path.insert(0, './bin/age_gender')
from age_gender_main import *

from threading import Thread

class attributeDetector():
    def __init__(self):
        self.r = {
            'id':None,
            'face':False,
            'gender':None,
            'age':None
        }
        
        self.face_detect = face_detection_model('dlib', './bin/age_gender/Model/shape_predictor_68_face_landmarks.dat')

        self.isComputing = False

        self.face_detect_thread = None

    def echo(self, id):
        return self.r

    def faceDetect(self, img):
        faces, face_files, rectangles, tgtdir = self.face_detect.run(img)
        print(faces)
        
    def faceDetectThread(self, id, img):
        if self.isComputing is False:
            self.face_detect_thread = Thread(target=self.faceDetect , args=(img))
            self.face_detect_thread.start()

    def genderDetector(self, id, face):
        pass