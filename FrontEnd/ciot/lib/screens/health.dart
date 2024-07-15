import 'package:flutter/material.dart';
import 'package:ciot/screens/mainpage.dart';

class HealthScreen extends StatelessWidget {
  HealthScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('CatIoT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
        centerTitle: true,
        backgroundColor: Colors.pink,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('우리 고양이의 건강 상태는?'),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  Text('오늘의 건강 분석'),
                  Text('식사: 양호'),
                  Text('배변: 양호'),
                ],
              ),
            ),
            Text('고양이의 주간 건강 분석'),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  Text('식사 기록 - 그래프'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  Text('배변 기록 - 그래프'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  Text('주간 종합 평가: 양호'),
                ],
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                },
                child: Text(
                  '메인으로 돌아가기',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/health');
              break;
            case 1:
              Navigator.pushNamed(context, '/catview');
            case 2:
              Navigator.pushNamed(context, '/catview');
            // default:
            //   Navigator.pushNamed(context, '/health');
            // ***디폴트 경로 설정: 필요할 경우 추가하기***
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: '건강 체크'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: '고양이 보기'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: '고양이 정보?'),
        ],
      ),
    );
  }
}
