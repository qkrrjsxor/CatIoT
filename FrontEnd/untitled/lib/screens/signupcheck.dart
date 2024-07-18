import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';

  Future<void> signup(String userId, String password,
      String catName, String catGender, String catAge) async {
    final response = await http.post(Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user': {
            'userId': userId,
            'password': password,
            'userName': userId
          },
          'cat': {
            'catName': catName,
            'catAge': int.parse(catAge),
            'catGender': catGender
          }
        }),
      );


    if (response.statusCode == 200) {
      print('회원가입 성공:${response.body}');
    } else {
      print('회원가입 실패:${response.body}');
    }
    // final abc = '123';
    // if (abc == '123') {
    //   print('회원가입 성공');
    // } else {
    //   print('회원가입 실패');
    // }
  }
}
