from time import time

def robotControl(client_socket, track_results, previous_movement_time):
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
        1. 타겟 크기가 일정 크기보다 크면 좌우를 찾기 힘들기 때문에 일정 크기 이상일 시 정지하는게 좋아보임. (완)
        2. 타켓 센터와 뷰 센터의 거리가 멀면 더 빠르게 이동할 것 (완)
        3. 바운더리 바깥에서 접근할 시(센서값으로 바운더리인지 확인), 처음부터 빠르게 이동할 필요가 있음. (완)
        4. 타임 버퍼를 두어서 새로 발견된 타겟은 바로 추적하고, 따라잡았을 경우엔 움직이지 않게 해야함. (완)
        '''
        movement_buffer = 0.12

        direction = '00'
        speed = '1011'

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

        if delta_t is None or delta_t >= 5:
            # 대기상태 -> 즉시 이동
            if _c >= center:
                # 우로 이동
                direction = '01'
                
            elif _c <= center:
                # 좌로 이동
                direction = '10'

        '''
        타겟과의 거리에 따른 로봇 이동 속도 계산
        speed 1 : 0111
        speed 2 : 1011
        speed 3 : 1111
        speed 4 : 1101
        speed 5 : 1110
        '''
        _distance = abs(_c - center)
        _distance_ratio = _distance / center
        _speed_interval = 0.2

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

        print(data)
        data = ''

        return movement_time