import functools
import json
from datetime import datetime
import time
import socket
import requests
import schedule

from utils import network_config


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