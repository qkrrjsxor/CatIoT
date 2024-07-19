import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/logincheck.dart';
import 'package:untitled/screens/feeder_manual.dart';


class ManualCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';
  // final String baseUrl = 'http://localhost:8080/api/user';

  Future<void> manual(BuildContext context, String manuals) async {
    print('수동 배급하자');
    try {
      final response = await http.post(Uri.parse('$baseUrl/manual_feeder'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': manuals, 'meal': int.parse(manuals)}));
      print('수동 배급 테스트');
      if (response.statusCode == 200) {
        print('배급 성공:${response.body}');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      } else {
        print('배급 실패:${response.body}');
      }
    } catch (_error) {
      print('연결 오류: $_error');
    }
  }
}
