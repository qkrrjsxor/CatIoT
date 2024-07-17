import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCheck {
  // final String baseUrl = 'http://localhost:8080/api/user';

  Future<void> login(String username, String password) async {
    // final response = await http.post(Uri.parse('$baseUrl/login'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({'username': username, 'password': password}));

    // if (response.statusCode == 200) {
    //   print('로그인 성공:${response.body}');
    // } else {
    //   print('로그인 실패:${response.body}');
    // }
    final abc = '123';
    if (abc == '123') {
      print('로그인 성공');
    } else {
      print('로그인 실패');
    }
  }
}
