import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/logincheck.dart';
import 'package:untitled/screens/feeder_auto.dart';

class AutoCheck {
  final String baseUrl = 'http://10.0.2.2:8080/api/user';
  // final String baseUrl = 'http://localhost:8080/api/user';

  Future<void> auto(BuildContext context, int meal1, int hour1, int min1,int meal2, int hour2, int min2,
      int meal3, int hour3, int min3,int meal4, int hour4, int min4,int meal5, int hour5, int min5,) async {
    print('ggg');
    print('자동 배급하자');
    int? firstmeal = meal1; int? firsthour = hour1; int? firstminute = min1;
    int? secondtmeal = meal2; int? secondhour = hour2; int? secondminute = min2;
    int? thirdmeal = meal3; int? thirdhour = hour3; int? thirdminute = min3;
    int? fourthmeal = meal4; int? fourthhour = hour4; int? fourthminute = min4;
    int? fifthmeal = meal5; int? fifthhour = hour5; int? fifthminute = min5;
    try {
    if (feedcounter == 0) {
    firstmeal = null; firsthour = null; firstminute = null;
    secondtmeal = null; secondhour = null; secondminute = null;
    thirdmeal = null;  thirdhour = null; thirdminute = null;
    fourthmeal = null;  fourthhour = null; fourthminute = null;
    fifthmeal = null;  fifthhour = null;  fifthminute = null;
    }
      else if (feedcounter == 1) {
         secondtmeal = null; secondhour = null; secondminute = null;
         thirdmeal = null;  thirdhour = null; thirdminute = null;
         fourthmeal = null;  fourthhour = null; fourthminute = null;
         fifthmeal = null;  fifthhour = null;  fifthminute = null;
      }
      else if (feedcounter == 2) {
        thirdmeal = null;  thirdhour = null; thirdminute = null;
        fourthmeal = null;  fourthhour = null; fourthminute = null;
        fifthmeal = null;  fifthhour = null;  fifthminute = null;
      }
      else if (feedcounter == 3 ) {
        fourthmeal = null;  fourthhour = null; fourthminute = null;
        fifthmeal = null;  fifthhour = null;  fifthminute = null;
      }
      else if (feedcounter == 4 ) {
        fifthmeal = null;  fifthhour = null;  fifthminute = null;
      }

      final response = await http.post(Uri.parse('$baseUrl/manual_feeder'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': loginName, 'meal': firstmeal}));
      print('자동 배급 테스트');
      print('~~~');
      print(thirdmeal);
    print(thirdhour);
    print(thirdminute);

      // print(firstmeal,firsthour, firstminute ,secondtmeal,secondhour,secondminute ,
      //     thirdmeal,thirdhour,thirdminute,fourthmeal,fourthhour,fourthminute,
      //     fifthmeal,fifthhour,fifthminute);
      print(firstmeal.runtimeType);
      print(firsthour.runtimeType);
      if (response.statusCode == 200) {
        print('자동 배급 성공:${response.body}');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
      } else {
        print('자동 배급 실패:${response.body}');
      }
    } catch (_error) {
      print('연결 오류: $_error');
    }
  }
}
