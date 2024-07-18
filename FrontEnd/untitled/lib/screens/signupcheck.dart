import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';

  Future<void> signup(String username, String password,
      String catname, String catgender, String catage) async {
    // final response = await http.post(Uri.parse('$baseUrl/signup'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({'username': username, 'password': password}, 'catname':catname, 'catgender':catgender, 'catage':catage));

    // if (response.statusCode == 200) {
    //   print('회원가입 성공:${response.body}');
    // } else {
    //   print('회원가입 실패:${response.body}');
    // }
    final abc = '123';
    if (abc == '123') {
      print('회원가입 성공');
    } else {
      print('회원가입 실패');
    }
  }
}
