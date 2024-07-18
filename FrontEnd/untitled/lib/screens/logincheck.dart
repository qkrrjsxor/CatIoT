import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/screens/mainpage.dart';

import 'login.dart';

class LoginCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';
  // final String baseUrl = 'http://localhost:8080/api/user';
  var loginAnswer = false;

  Future<void> login(BuildContext context, String userId, String password) async {
    print('login 함수 실행');
    try {
      final response = await http.post(Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'password': password}));
      print('비동기 테스트');
      if (response.statusCode == 200) {
        print('로그인 성공:${response.body}');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      } else {
        print('로그인 실패:${response.body}');
        Fluttertoast.showToast(
          msg: '${response.body}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('연결 오류: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    print('logout 함수 실행');
    try {
      final response = await http.get(Uri.parse('$baseUrl/logout'));

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          )
      );
    } catch (e) {
      print('연결 오류: $e');
    }
  }
}
