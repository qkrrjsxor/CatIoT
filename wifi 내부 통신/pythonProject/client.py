import socket
#sample
def start_client():
    # 서버 설정
    host = '70.12.108.100'  # 서버 호스트 (서버와 동일한 호스트)
    port = 65432        # 포트 번호 (서버와 동일한 포트)

    # 소켓 생성
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))  # 서버에 연결

        while True:
            # 사용자 입력 받기
            message = input("Enter message to send to server: ")
            if message.lower() == 'exit':
                break

            # 서버로 데이터 전송
            s.sendall(message.encode())

            # 서버로부터 데이터 수신
            data = s.recv(1024)
            print(f"Received from server: {data.decode()}")

if __name__ == "__main__":
    start_client()
