import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/screens/login.dart';

class SignupCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';

  Future<void> signup(BuildContext context ,String userId, String password,
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
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      Fluttertoast.showToast(
        msg: '회원가입에 성공하였습니다.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print('회원가입 실패:${response.body}');
      Fluttertoast.showToast(
        msg: '이미 존재하는 아이디입니다.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('이미 존재하는 아이디입니다.'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }
}
