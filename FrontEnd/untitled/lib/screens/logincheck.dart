import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';
  // final String baseUrl = 'http://localhost:8080/api/user';
  var loginAnswer = false;

  Future<void> login(String username, String password) async {
    print('login 함수 실행');
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': 'ssafy', 'password': '1234'}));
    print('비동기 테스트');
    if (response.statusCode == 200) {
      print('로그인 성공:${response.body}');
    } else {
      print('로그인 실패:${response.body}');
    }
    // final abc = '123';
    // if (abc == '123') {
    //   print('로그인 성공');
    //   loginAnswer = true;
    // } else {
    //   print('로그인 실패');
    // }
  }
}
