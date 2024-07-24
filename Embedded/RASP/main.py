import socket
import time
import requests
import json
import threading
import schedule
from datetime import datetime

# 사용자 지정 라이브러리
import network_config

# 추가해야 할 거 : 매 시간마다 밥그릇의 무게값을 서버로 전송 -> 쓰레딩 + 스케쥴링 라이브러리로 구현
#
def main():
    # STM thread
    STM = threading.Thread(target=stm_thread())
    STM.start()

def stm_thread():
    # 서버 설정
    HOST = network_config.RASP_IP  # 모든 인터페이스에서 수신
    PORT = network_config.PORT  # ESP-01에서 연결할 포트

    # 소켓 생성
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((HOST, PORT))
    server_socket.listen(1)

    print(f"서버가 {HOST}:{PORT}에서 대기 중입니다.")

    # 클라이언트 연결 수락
    client_socket, client_address = server_socket.accept()
    print(f"{client_address}에서 연결되었습니다.")

    try:
        while True:
            # 데이터 송신 -> ACK로 OK 받기 전 까지 2초 간격으로 10차례 보내기
            time.sleep(15)
            # 데이터 송신
            send_STM32(client_socket, "100")

            time.sleep(15)
            # 밥그릇 무게 데이터 요청 신호 송신
            send_STM32(client_socket, "1000")

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
def meal_send_data(data):

    headers = {
        "Content-Type": "application/json"
    }

    response = requests.post(network_config.MEAL_URL, headers=headers, data=json.dumps(data))

    print(f"Status Code: {response.status_code}")
    print(f"Response Text: {response.text}")


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

if __name__ == '__main__':
    main()