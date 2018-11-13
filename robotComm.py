from time import time
import random
from sender import PollySender

from bin.color_extractor.color_extractor import ImageToColor
import numpy as np

from attributeDetector import attributeDetector

ps = PollySender()
npz = np.load('bin/color_extractor/color_names.npz')
img_to_color = ImageToColor(npz['samples'], npz['labels'])

ad = attributeDetector()

def crop_img(img,target):
    startx = int(target['topleft']['x'])
    starty = int(target['topleft']['y'])
    endx = int(target['bottomright']['x'])
    endy = int(target['bottomright']['y'])

    return img[starty:endy,startx:endx]

def resetVar(v):
    print("Reset Var")
    return {
                'target_id' : None,
                'target_color' : None,

                'prev_target_id' : None,

                'flag' : None,

                'spoken_flag' : {
                    'new': False,
                    'clothes_color': False,
                    'face': False
                }
            }

def robotControl(_var, robot_ip, client_socket, track_results, previous_movement_time, frame):
    _s = 0
    target = None
    
    if _var is None:
        _var = resetVar(_var)

    for _t in track_results:
        _size = _t['bottomright']['x'] - _t['topleft']['x']

        if _size > _s:
            target = _t
            _var['target_id'] = target['label']
            _s = _size

    if target is not None:
        

        _c = frame.shape[1] / 2
        center = ( target['bottomright']['x'] + target['topleft']['x'] ) / 2
        width = target['bottomright']['x'] - target['topleft']['x']
        '''
        1. 타겟 크기가 일정 크기보다 크면 좌우를 찾기 힘들기 때문에 일정 크기 이상일 시 정지하는게 좋아보임. (완)
        2. 타켓 센터와 뷰 센터의 거리가 멀면 더 빠르게 이동할 것 (완)
        3. 바운더리 바깥에서 접근할 시(센서값으로 바운더리인지 확인), 처음부터 빠르게 이동할 필요가 있음. (완)
        4. 타임 버퍼를 두어서 새로 발견된 타겟은 바로 추적하고, 따라잡았을 경우엔 움직이지 않게 해야함. (완)
        '''
        movement_buffer = 0.12

        direction = '00'
        speed = '1011'
        polly_msg = None

        if previous_movement_time is not None:
            delta_t = time() - previous_movement_time
        else:
            delta_t = None

        '''
        이동 유무 및 방향 계산
        '''
        if delta_t is not None:
            if delta_t < 5:
                # 추적 중 -> 이동 버퍼 작동
                if _c >= center * (1+movement_buffer):
                    # 우로 이동
                    direction = '01'
                    
                elif _c <= center * (1-movement_buffer):
                    # 좌로 이동
                    direction = '10'

                else:
                    # 정지
                    direction = '11'

                    movement_time = None
        print('detect_ratio', width / (center * 2))
        if width / (center * 2) > 0.7:
            direction = '11'

            movement_time = None

        print(delta_t)
        if delta_t is None or delta_t >= 5:
            # 대기상태 -> 즉시 이동
            if _c >= center:
                # 우로 이동
                direction = '01'
                
            elif _c <= center:
                # 좌로 이동
                direction = '10'
        
        # else:
        #     direction = '11'

            

        '''
        타겟과의 거리에 따른 로봇 이동 속도 계산
        speed 1 : 0111
        speed 2 : 1011
        speed 3 : 1111
        speed 4 : 1101
        speed 5 : 1110
        '''
        _distance = abs(_c - center)

        _distance_ratio = _distance / _c
        _speed_interval = 0.4

        # print("Distance ratio",_distance_ratio)

        if _distance_ratio >= (1-_speed_interval):
            _s = 1
        elif _distance_ratio >= (1-_speed_interval*2) and _distance_ratio < (1-_speed_interval*1):
            _s = 2
        elif _distance_ratio <= (1-_speed_interval*2):
            _s = 3

        if _s == 1:
            speed = '0111'
        elif _s == 2:
            speed = '1011'
        elif _s == 3:
            speed = '1111'
        elif _s == 4:
            speed = '1101'
        elif _s == 5:
            speed = '1110'

        if direction != '00':
            movement_time = time()

            _m = "".join(['STX',direction,speed,'ETX'])
            msg = str(len(_m)).zfill(4) + _m
            client_socket.send(msg.encode())

        '''
        음성 재생
        '''
        print("Start:",_var)
        
        # print("Target ID:", _var['target_id'], "Prev ID:", _var['prev_target_id'])
        if _var['spoken_flag']['new'] == False:
            _var['flag'] = 'new'

        if _var['prev_target_id'] is not None and _var['target_id'] != _var['prev_target_id']:
            # 신규 추적 대상
            _var = resetVar(_var)
            _var['flag'] = 'new'

        try:
            if _var['spoken_flag']['new'] is True and _var['spoken_flag']['clothes_color'] is False:
                target_img_box = crop_img(frame, target)
                c = img_to_color.get(target_img_box)
                if _var['spoken_flag']['clothes_color'] == False and len(c) > 0 and _var['spoken_flag']['new'] == True:
                    _var['target_color'] = c[0]
                    # print(_var['target_color'])
                    _var['flag'] = 'clothes_color'
        except Exception as ex:
            pass

        if _var['spoken_flag']['new'] is True and _var['spoken_flag']['face'] is False: 
            _r = ad.echo(_var['target_id'])
            # print(_r)

        if ps._t is None or ps._t.isAlive() is False:
            if _var['flag'] == 'new':
                polly_msg = random.choice(['안녕하세요!', '반가워요!', '반갑습니다.', '어서오세요'])
                _var['prev_target_id'] = _var['target_id']
                _var['spoken_flag']['new'] = True
            elif _var['flag'] == 'clothes_color':
                _var['spoken_flag']['clothes_color'] = True

                if _var['target_color'] == 'blue':
                    polly_msg = '파란옷이 잘 어울리시네요.'
                    
                elif _var['target_color'] == 'red':
                    polly_msg = '빨간옷이 잘 어울리시네요.'
                    
                else:
                    _var['spoken_flag']['clothes_color'] = False
                
            else:
                polly_msg = None

            if polly_msg is not None:
                ps.send(robot_ip, polly_msg)
                _var['flag'] = None
                polly_msg = None

        data = ''
        print("End:",_var)
        return _var, movement_time