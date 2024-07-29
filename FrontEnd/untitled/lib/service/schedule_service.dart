import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/health.dart';
import '../screens/feeder_auto.dart';
import '../screens/logincheck.dart';
import '../screens/mainpage.dart';

class ScheduleService {
  // final String baseUrl = 'http://10.0.2.2:8080/api/meal';
  final String baseUrl = 'http://i11a205.p.ssafy.io:8080/api/meal';

  Future<void> schedulecheck(

      BuildContext context, int catId, _daycheck) async {
      DateTime abc = DateTime.now();

      try {
        final response = await http.post(
          Uri.parse('$baseUrl/schedulecheck'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'catId': catId, 'mealDate': abc, 'mealAmount':300}),
        );
        print(response.statusCode);
      } catch (_error) {
        print('연결 오류: $_error');
      }

  }

}
