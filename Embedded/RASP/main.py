import functools
import socket
import time
import requests
import json
import threading
import schedule
from datetime import datetime

# 2024-07-24
# 사용자 지정 라이브러리
import network_config

def main():
    # schedule
    # STM thread
    stm = threading.Thread(target=stm_thread)
    stm.start()

    # SERVER thread
    server = threading.Thread(target=server_thread)
    server.start()

def server_thread():
    HOST = network_config.RASP_IP  # 모든 인터페이스에서 수신
    PORT = network_config.SERVER_COMMUNICATION_PORT  # SERVER 에서 연결할 포트

    # 소켓 생성
    while True:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.bind((HOST, PORT))
        server_socket.listen(1)

        print(f"{HOST}:{PORT}에서 서버 명령 대기 중입니다.")

        # 클라이언트 연결 수락
        client_socket, client_address = server_socket.accept()
        print(f"{client_address}에서 연결되었습니다.")

        try:
            while True:
                # TODO : 서버에서 명령을 받고, STM에 데이터를 보내는 것과 스케줄 변경 기능 구현 예정
                print("서버 연결 GOAT")
                time.sleep(1)


        finally:
            # 연결 종료
            client_socket.close()
            server_socket.close()
            print("서버가 종료되었습니다.")
def stm_thread():
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

    # 기본 셋팅
    setting_device(client_socket)
    reserve_send_data(client_socket)

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


            # 데이터 송신
            # send_STM32(client_socket, "100")

            # 밥그릇 무게 데이터 요청 신호 송신
            # send_STM32(client_socket, "1000")

    finally:
        # 연결 종료
        client_socket.close()
        server_socket.close()
        print("서버가 종료되었습니다.")

# 데이터 수신
def receive_data(client_socket, buffer_size=1024, timeout=5):
    client_socket.settimeout(timeout)
    try:
        data = client_socket.recv(buffer_size).decode()
        # print(data)
        return data
    except socket.timeout:
        print("수신 타임아웃")
        return "FAIL"
    except Exception as e:
        print(f"수신 에러: {e}")
        return "FAIL"


# Rasp -> Server
# HTTP POST -> SERVER : 현재 밥그릇 무게 데이터 전송
def meal_send_data(data):

    headers = {
        "Content-Type": "application/json"
    }

    response = requests.post(network_config.MEAL_URL, headers=headers, data=json.dumps(data))

    print(f"Status Code: {response.status_code}")
    print(f"Response Text: {response.text}")


# 급여 간격 설정
def setting_device(client_socket):
    count = 0

    # 10초 동안 기다려보자 ~~!
    while(count <= 10):

        response = requests.get(network_config.MEAL_SCHEDULE_URL)
        if (response.status_code == 200):
            # 시간값 저장
            time_data = response.json()
            print(time_data)

            for i in range(1, time_data["scheduleCount"] + 1, 1):
                set_time = time_data[f"scheduleTime{i}"]
                schedule.every().day.at(set_time).do(functools.partial(send_STM32, client_socket, str(time_data[f"scheduleAmount{i}"])))

                # test : 예약해보기
            # schedule.every().day.at("14:14").do(functools.partial(send_STM32, client_socket, "100"))
            # schedule.every().day.at("14:15").do(functools.partial(send_STM32, client_socket, "1000"))

            return 1

        time.sleep(1)
        count += 1
    # 제대로 연결 되지 않았을 경우 -1
    return -1

# send_STM32
def send_STM32(client_socket, message):
    count = 0

    if (message == "1000"):

        while (count <= 10):
            # 신호 요청
            client_socket.send(message.encode())
            print(f"#{count} 송신된 데이터: {message}")
            data = receive_data(client_socket)
            if ("OK" in data):
                result = receive_data(client_socket)
                current_time = datetime.now().strftime("%Y-%m-%d %H:%M")

                send_data = {
                    "mealDate": current_time,
                    "mealAmount": result,
                }

                meal_send_data(send_data)
                break

            # 수신 실패시 시간 추가
            count += 1

    else:
        # 모터 신호 송신
        while (count <= 10):
            # 신호 송신
            client_socket.send(message.encode())
            print(f"#{count} 송신된 데이터: {message}")
            data = receive_data(client_socket)
            if ("OK" in data):
                print(data)
                break
            count += 1

# 매 시 정각에 밥그릇 무게 측정 후 서버로 전송
def reserve_send_data(client_socket):
    for i in range(0, 24, 1):
        if (i < 10):
            schedule.every().day.at(f"0{i}:00").do(functools.partial(send_STM32, client_socket, "1000"))
        else:
            schedule.every().day.at(f"{i}:00").do(functools.partial(send_STM32, client_socket, "1000"))

    # print("OK GOAT")

if __name__ == '__main__':
    main()