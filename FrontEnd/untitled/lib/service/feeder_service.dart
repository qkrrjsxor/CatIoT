import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/feeder_auto.dart';
import '../screens/logincheck.dart';
import '../screens/mainpage.dart';

class FeederService {
  // final String baseUrl = 'http://10.0.2.2:8080/api/meal';
  final String baseUrl = 'http://i11a205.p.ssafy.io:8080/api/meal';

  // 수동 급여
  Future<void> manualFeed(
      BuildContext context, int catId, String mealAmount) async {
    int feedAmount = int.parse(mealAmount);
    print(catId);
    print(feedAmount);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/manualfeed'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'catId': catId, 'feedAmount': feedAmount}),
      );
      if (response.statusCode == 200) {
        print('수동 급여 성공: ${response.body}');
      }
    } catch (_error) {
      print('연결 오류: $_error');
    }
  }

  // 자동 급여
  Future<void> autoFeed(
      BuildContext context, scheduleCount,
      _firsttime, _firstmeal, _secondtime, _secondmeal, _thirdtime, _thirdmeal,
      _fourthtime, _fourthmeal, _fifthtime, _fifthmeal) async {
    print('자동 배급 체크 페이지로 넘어왔습니다');

    String? _firstTotalTime = '${_firsttime.hour.toString().padLeft(2,'0')}:${_firsttime.minute.toString().padLeft(2,'0')}';
    String? _secondTotalTime = '${_secondtime.hour.toString().padLeft(2,'0')}:${_secondtime.minute.toString().padLeft(2,'0')}';
    String? _thirdTotalTime = '${_thirdtime.hour.toString().padLeft(2,'0')}:${_thirdtime.minute.toString().padLeft(2,'0')}';
    String? _fourthTotalTime = '${_fourthtime.hour.toString().padLeft(2,'0')}:${_fourthtime.minute.toString().padLeft(2,'0')}';
    String? _fifthTotalTime = '${_fifthtime.hour.toString().padLeft(2,'0')}:${_fifthtime.minute.toString().padLeft(2,'0')}';

    print(_firsttime);
    print(_firstTotalTime);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("scheduleCount", scheduleCount);
    if(scheduleCount >= 5){
      await prefs.setString("scheduleTime5", _fifthTotalTime);
      await prefs.setInt("scheduleAmount5", _fifthmeal);
    }
    if(scheduleCount >= 4){
      await prefs.setString("scheduleTime4", _fourthTotalTime);
      await prefs.setInt("scheduleAmount4", _fourthmeal);
    }
    if(scheduleCount >= 3){
      await prefs.setString("scheduleTime3", _thirdTotalTime);
      await prefs.setInt("scheduleAmount3", _thirdmeal);
    }
    if(scheduleCount >= 2){
      await prefs.setString("scheduleTime2", _secondTotalTime);
      await prefs.setInt("scheduleAmount2", _secondmeal);
    }
    if(scheduleCount >= 1){
      await prefs.setString("scheduleTime1", _firstTotalTime);
      await prefs.setInt("scheduleAmount1", _firstmeal);
    }

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
          body: jsonEncode({
            'catId': CatInfo![0]['catId'],
            'scheduleCount': scheduleCount,
            'scheduleTime1': _firstTotalTime,
            'scheduleTime2': _secondTotalTime,
            'scheduleTime3': _thirdTotalTime,
            'scheduleTime4': _fourthTotalTime,
            'scheduleTime5': _fifthTotalTime,
            'scheduleAmount1': _firstmeal,
            'scheduleAmount2': _secondmeal,
            'scheduleAmount3': _thirdmeal,
            'scheduleAmount4': _fourthmeal,
            'scheduleAmount5': _fifthmeal}));

      if (response.statusCode == 200) {
        print('자동 배급 시간 설정 성공:${response.body}');

      } else {
        print('자동 배급 시간 설정 실패:${response.body}');
      }
    } catch (_error) {
      print('연결 오류: $_error');
    }
  }
}
