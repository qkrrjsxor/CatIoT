import socket


import socket

def start_server():
    # 서버 설정
    host = '0.0.0.0'  # 로컬 호스트
    port = 65432        # 포트 번호

    # 소켓 생성
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))  # 호스트와 포트를 바인딩
        s.listen()            # 연결 대기 상태로 설정
        print(f"Server listening on {host}:{port}")

        # 클라이언트 연결 수락
        conn, addr = s.accept()
        with conn:
            print(f"Connected by {addr}")

            while True:
                # 클라이언트로부터 데이터 수신
                data = conn.recv(1024)
                if not data:
                    break
                print(f"Received from client: {data.decode()}")

                # 클라이언트로 데이터 전송
                response = "Server received: " + data.decode()
                conn.sendall(response.encode())

if __name__ == "__main__":
    start_server()
