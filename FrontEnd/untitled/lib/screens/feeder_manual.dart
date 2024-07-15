import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';

class ManualScreen extends StatelessWidget {
  final String screenData;

  ManualScreen({required this.screenData});
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 300,
              child: Column(
                children: [
                  Text('수동 배급 설정',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                  SizedBox(height: 10),
                  Text(
                    '10g 단위로 설정 가능합니다',
                    style: TextStyle(color: Colors.black38),
                  ),
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
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(223, 197, 197, 197),
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(223, 197, 197, 197),
                                      )))),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'g',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                '배급하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
