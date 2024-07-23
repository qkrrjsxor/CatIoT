import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/catscreen.dart';
import 'package:untitled/screens/health.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/feeder_manual.dart';
import 'package:untitled/screens/feeder_auto.dart';
import 'package:untitled/screens/logincheck.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final LoginCheck loginCheck = LoginCheck();
  String? selectedCatName; // 선택된 고양이 이름을 저장할 변수

  @override
  void initState() {
    super.initState();
    // 처음에 선택된 고양이 이름 설정
    if (CatInfo != null && CatInfo!.isNotEmpty) {
      selectedCatName = CatInfo![0]['catName'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        actions: [
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 30),
            if (CatInfo != null && CatInfo!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: selectedCatName,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.pink),
                  dropdownColor: Colors.white,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCatName = newValue!;
                    });
                  },
                  items: CatInfo!.map<DropdownMenuItem<String>>((dynamic cat) {
                    return DropdownMenuItem<String>(
                      value: cat['catName'],
                      child: Text(cat['catName']),
                    );
                  }).toList(),
                ),
              ),
          ])),
        ],
        // leading:
        // Container(
        //     child:Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           SizedBox(width:30),
        //           Flexible(
        //             child:Container(
        //
        //             ),
        //           ),
        //           if (CatInfo != null && CatInfo!.isNotEmpty)
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: DropdownButton<String>(
        //                 value: selectedCatName,
        //
        //                 icon: Icon(Icons.arrow_drop_down, color: Colors.pink),
        //                 dropdownColor: Colors.white,
        //                 onChanged: (String? newValue) {
        //                   setState(() {
        //                     selectedCatName = newValue!;
        //                   });
        //                 },
        //                 items: CatInfo!.map<DropdownMenuItem<String>>((dynamic cat) {
        //                   return DropdownMenuItem<String>(
        //                     value: cat['catName'],
        //                     child: Text(cat['catName']),
        //                   );
        //                 }).toList(),
        //               ),
        //             ),
        //         ]
        //     )
        // ),

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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: 30),
              Container(),
            ])),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color.fromARGB(255, 235, 235, 235))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 고양이 이름이 뜨도록 변경
                  Text('${selectedCatName} 집사님, 환영합니다',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    onPressed: () async {
                      await loginCheck.logout(context);
                    },
                    child: Text('로그아웃',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text('오늘의 식사 기록',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('냠냠'),
                        // Text('2번'),
                        // Text('3번'),
                        // Text('4번'),
                        // Text('5번'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text('오늘의 배변 기록',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('냠냠'),
                        // Text('2번'),
                        // Text('3번'),
                        // Text('4번'),
                        // Text('5번'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('자동 배급',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255)),
                          onPressed: () {
                            //
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeederAuto()));
                          },
                          child: Text('설정',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('1번'),
                        Text('2번'),
                        Text('3번'),
                        Text('4번'),
                        Text('5번'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('수동 배급',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255)),
                          onPressed: () {
                            //
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeederManual(),
                                ));
                          },
                          child: Text('설정',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('1번'),
                        Text('2번'),
                        Text('3번'),
                        Text('4번'),
                        Text('5번'),
                      ],
                    ),
                  ),
                ],
              ),
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
