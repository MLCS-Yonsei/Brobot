def robotControl(client_socket, track_results):
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
        4. 타임 버퍼를 두어서 이동하는 타겟은 바로 추적하고, 따라잡았을 경우엔 움직이지 않게 해야함.
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