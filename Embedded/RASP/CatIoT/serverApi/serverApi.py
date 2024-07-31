import json
from http.server import BaseHTTPRequestHandler

from stmApi.stmApi import send_STM32


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    global stm_client_socket
    def _set_cors_headers(self):
        # CORS 헤더 추가
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")

    def do_OPTIONS(self):
        # Pre-flight 요청에 대한 응답 설정
        self.send_response(200)
        self._set_cors_headers()
        self.end_headers()

    def do_POST(self):
        self._set_cors_headers()
        # 수동 배급 요청이 POST로 들어오면, STM에 신호 보내깅
        if self.path == "/api/manualMeal":
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            try:
                # JSON 데이터 파싱
                data = json.loads(post_data)
                print("Received data:", data)

                # 응답 설정
                self.send_response(200)
                self.send_header("Content-type", "application/json")
                self.end_headers()

                # 응답 내용 작성
                response = {"message": "Data received successfully"}
                self.wfile.write(json.dumps(response).encode("utf-8"))

                # stm에 신호 보내깅 ~~!
                send_STM32(stm_client_socket, str(data["mealAmount"]))

            except json.JSONDecodeError:
                self.send_response(400)
                self.send_header("Content-type", "application/json")
                self.end_headers()
                response = {"message": "Invalid JSON"}
                self.wfile.write(json.dumps(response).encode("utf-8"))

        # TODO : 자동 배급 수정 POST 요청을 받으면 schedule 모두 초기화 후 재등록
        elif self.path == "/api/mealAuto":
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            try:
                # JSON 데이터 파싱
                data = json.loads(post_data)
                print("Received data:", data)

                # 응답 설정
                self.send_response(200)
                self.send_header("Content-type", "application/json")
                self.end_headers()

                # 응답 내용 작성
                response = {"message": "Data received successfully"}
                self.wfile.write(json.dumps(response).encode("utf-8"))
            except json.JSONDecodeError:
                self.send_response(400)
                self.send_header("Content-type", "application/json")
                self.end_headers()
                response = {"message": "Invalid JSON"}
                self.wfile.write(json.dumps(response).encode("utf-8"))

        else:
            self.send_response(404)
            self.end_headers()
            response = {"message": "Not Found"}
            self.wfile.write(json.dumps(response).encode("utf-8"))