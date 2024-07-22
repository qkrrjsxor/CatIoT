import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/logincheck.dart';
import 'package:untitled/screens/feeder_auto.dart';

class AutoCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/meal';
  // final String baseUrl = 'http://localhost:8080/api/user';

  Future<void> auto(
      BuildContext context,
      _firsttime, _firstmeal, _secondtime, _secondmeal, _thirdtime, _thirdmeal,
      _fourthtime, _fourthmeal, _fifthtime, _fifthmeal) async {
    print('자동 배급 체크 페이지로 넘어왔습니다');

    String? _firstTotalTime = '${_firsttime.hour}:${_firsttime.minute}';
    String? _secondTotalTime = '${_secondtime.hour}:${_secondtime.minute}';
    String? _thirdTotalTime = '${_thirdtime.hour}:${_thirdtime.minute}';
    String? _fourthTotalTime = '${_fourthtime.hour}:${_fourthtime.minute}';
    String? _fifthTotalTime = '${_fifthtime.hour}:${_fifthtime.minute}';

    try {

    if (feedcounter == 0) {
      _firstTotalTime = null;_secondTotalTime = null;_thirdTotalTime = null;
      _fourthTotalTime = null;_fifthTotalTime = null;
    }
      else if (feedcounter == 1) {
      _secondTotalTime = null;_thirdTotalTime = null;
      _fourthTotalTime = null;_fifthTotalTime = null;
      }
      else if (feedcounter == 2) {
      _thirdTotalTime = null;_fourthTotalTime = null;
      _fifthTotalTime = null;
      }
      else if (feedcounter == 3 ) {
      _fourthTotalTime = null;_fifthTotalTime = null;
      }
      else if ( feedcounter == 4 ) {
      _fifthTotalTime = null;
      }
      print('check~~~~~~');
      // print(CatInfo![0]['catId']);
      // print(_firstTotalTime);
      // print(_thirdTotalTime);
      final response = await http.post(Uri.parse('$baseUrl/autofeed'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'cat_id': CatInfo![0]['catId'],
            'meal_time1': _firstTotalTime,
            'meal_time2': _secondTotalTime,
            'meal_time3': _thirdTotalTime,
            'meal_time4': _fourthTotalTime,
            'meal_time5': _fifthTotalTime,
            'meal_scheduled_amount1': _firstmeal,
            'meal_scheduled_amount2': _secondmeal,
            'meal_scheduled_amount3': _thirdmeal,
            'meal_scheduled_amount4': _fourthmeal,
            'meal_scheduled_amount5': _fifthmeal}));

      if (response.statusCode == 200) {
        print('자동 배급 시간 설정 성공:${response.body}');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      } else {
        print('자동 배급 시간 설정 실패:${response.body}');
      }
    } catch (_error) {
      print('연결 오류: $_error');
    }
  }
}
