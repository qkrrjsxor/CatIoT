import functools
import socket
import time
import requests
import json
import threading
import schedule
from datetime import datetime
from http.server import HTTPServer

from serverApi.serverApi import SimpleHTTPRequestHandler
from stmApi.stmApi import setting_device, reserve_send_data
# 2024-07-25 14:00
# 사용자 지정 라이브러리
from utils import network_config

# STM 연결 시 server_thread에 STM 객체를 보내기 위한 변수
stm_client_socket = None
def main():
    # schedule
    # STM thread
    stm = threading.Thread(target=stm_thread)
    stm.start()

    # SERVER thread
    server = threading.Thread(target=server_thread)
    server.start()

def server_thread(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler, port=50000):
    global stm_client_socket

    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f"Starting httpd server on port {port}")
    httpd.serve_forever()

def stm_thread():
    # 전역변수 stm_client
    global stm_client_socket
    # 서버 설정
    HOST = network_config.RASP_IP  # 모든 인터페이스에서 수신
    PORT = network_config.PORT  # ESP-01에서 연결할 포트

    # 소켓 생성
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((HOST, PORT))
    server_socket.listen(1)

    print(f"{HOST}:{PORT}에서 STM32 연결 대기 중입니다.")

    # 클라이언트 연결 수락
    client_socket, client_address = server_socket.accept()
    print(f"STM32 : {client_address}에 연결되었습니다.")

    # TODO : 건택이 형님 오면 테스트 ㄱㄱ
    # 기본 셋팅
    setting_device(client_socket)
    reserve_send_data(client_socket)

    # 서버 통신을 위한 전역변수
    stm_client_socket = client_socket

    try:
        while True:
            # 데이터 송신 -> ACK로 OK 받기 전 까지 2초 간격으로 10차례 보내기
            # 스케쥴러 실행, 등록된 시간이 되면 특정 행동 수행~!
            # 1. 시간이 되면, 데이터 전송
            # 2. 설정한 시간이 되면, 배급 신호 송신
            schedule.run_pending()

            # Test :
            # jobs = schedule.get_jobs()
            # for job in jobs:
            #     print(f"예약된 작업: {job}")
            time.sleep(1)

    finally:
        # 연결 종료
        client_socket.close()
        server_socket.close()
        print("서버가 종료되었습니다.")

if __name__ == '__main__':
    main()