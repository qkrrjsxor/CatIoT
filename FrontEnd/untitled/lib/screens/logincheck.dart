import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:untitled/screens/mainpage.dart';

import '../service/cookie_manager.dart';
import 'login.dart';

// 고양이 정보를 담을 전역변수
List<dynamic>? CatInfo;

class LoginCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';
  final CookieManager cookieManager = CookieManager();
  var loginAnswer = false;

  Future<bool> login(
      BuildContext context, String userId, String password) async {
    print('login 함수 실행');
    try {
      final response = await http.post(Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'password': password}));
      print('비동기 테스트');

      if (response.statusCode == 200) {
        print('로그인 성공:${response.body}');
        CatInfo = jsonDecode(response.body);
        print(CatInfo);
        // var cat = CatInfo![0];
        // print('고양이 이름: ${cat['catName']}');

        // Save cookies from the response
        final uri = Uri.parse(baseUrl);
        final cookies = response.headers['set-cookie'];
        if (cookies != null) {
          final parsedCookies = cookies
              .split(',')
              .map((str) => Cookie.fromSetCookieValue(str))
              .toList();
          await cookieManager.saveFromResponse(uri, parsedCookies);
        }

        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
        return true;
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
        return false;
      }
    } catch (e) {
      print('연결 오류: $e');
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    print('logout 함수 실행');
    try {
      final uri = Uri.parse(baseUrl);
      final cookies = await cookieManager.loadForRequest(uri);
      final headers = {
        'Cookie':
            cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ')
      };

      final response = await http.get(
        Uri.parse('$baseUrl/logout'),
        headers: headers,
      );

      if (response.statusCode == 202) {
        cookieManager.clear();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        Fluttertoast.showToast(
          msg: '로그아웃 실패: ${response.body}',
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

  // 로그인 정보 저장
  Future<void> saveLoginInfo(String userId, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('password', password);
  }

  // 로그인 정보 불러오기
  Future<Map<String, String?>> getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? password = prefs.getString('password');
    return {'userId': userId, 'password': password};
  }
}
