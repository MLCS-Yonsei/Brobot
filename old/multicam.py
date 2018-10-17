import time

from multiprocessing import Process, Queue


# Init Multi Cams
CAM_IDS = [0,1]

def cam_show(CAM_ID):
    import cv2

    cam = cv2.VideoCapture(int(CAM_ID))

    cv2.namedWindow('Cam'+str(CAM_ID))
    
    prevTime = 0

    while (True):
        ret, frame = cam.read()

        if frame is not None:
            print(CAM_ID)
            # Detection

            curTime = time.time()
            sec = curTime - prevTime
            prevTime = curTime
            fps = 1 / (sec)

            fps_str = "FPS : %0.1f" % fps

            cv2.putText(frame, fps_str, (5, 20), cv2.FONT_HERSHEY_PLAIN, 1, (0, 255, 0))
            cv2.imshow('Cam'+str(CAM_ID),cv2.resize(frame, (1300, 800)))

            if cv2.waitKey(1) & 0xFF == ord('q'):
                cam.release()
                cv2.destroyWindow('Cam'+str(CAM_ID))
                break

# Multi Process
procs = []
for CAM_ID in CAM_IDS:
    proc = Process(target=cam_show, args=(str(CAM_ID)))
    procs.append(proc)

for proc in procs:
    proc.start()
