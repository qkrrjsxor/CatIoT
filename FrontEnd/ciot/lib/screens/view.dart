import 'package:flutter/material.dart';
import 'package:ciot/screens/mainpage.dart';

class CatScreen extends StatelessWidget {
  // final String screenData;
// ★ 로그인 된 사용자임을 인증 받아야 함
// ★ 아닌 경우 로그인 페이지로 이동
  CatScreen();
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
            Text('우리 고양이의 모습은?'),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 400,
              height: 400,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: Column(
                children: [
                  Text('★★★★홈캠★★★★'),
                ],
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
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
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
