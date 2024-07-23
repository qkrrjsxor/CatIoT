import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/manual_check.dart';
import 'package:untitled/service/feeder_service.dart';

import 'logincheck.dart';

class FeederManual extends StatefulWidget {
  const FeederManual({super.key});
  @override
  State<FeederManual> createState() => ManualScreen();
}

class ManualScreen extends State<FeederManual>{
  final ManualCheck manualCheck = ManualCheck();
  final FeederService feederService = FeederService();
  TextEditingController manualController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                              controller: manualController,
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
            // 취소 버튼 추가, 메인화면으로 이동
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () async {
                    // await manualCheck.manual(context, manualController.text);
                    await feederService.manualFeed(context, CatInfo![0]['catId'], manualController.text);
                    print(manualController.text);
                    // Navigator.of(context).pop();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MainScreen(),
                    //     ));
                  },
                  child: Text(
                    '배급하기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/health');
              break;
            case 1:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/mainpage');
              break;
            case 2:
              Navigator.pop(context);
              Navigator.pushNamed(context, '/catview');
              break;
          // default:
          //   Navigator.pushNamed(context, '/health');
          // ***디폴트 경로 설정: 필요할 경우 추가하기***
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: '고양이 건강 체크'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '메인 페이지'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: '고양이 보러가기'),
        ],
      ),
    );
  }
}
