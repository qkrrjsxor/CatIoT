import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';

class FeederAuto extends StatefulWidget {
  const FeederAuto({super.key});

  @override
  State<FeederAuto> createState() => AutoScreen();
}

class AutoScreen extends State<FeederAuto> {
  // db에 저장 된 시간이 있으면 불러오자
  TimeOfDay firstTime = TimeOfDay.now(); // 현재 시간 기준으로 시간대를 생성하는 생성자
  TimeOfDay secondTime = TimeOfDay.now();
  TimeOfDay thirdTime = TimeOfDay.now();

  final TextEditingController _firstFood = TextEditingController();
  final TextEditingController _secondFood = TextEditingController();
  final TextEditingController _thirdFood = TextEditingController();
  // AutoScreen();
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
                  Text('자동 배급 설정',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                  SizedBox(height: 10),
                  Text(
                    '하루 최대 5회까지 설정 가능합니다',
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              width: 300,
              child: Column(
                children: [
                  Text('하루 2회',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 228, 6, 95))),
              child: Row(
                children: [
                  Text(
                    '${firstTime.hour}:${firstTime.minute}',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () async {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          // showTimePicker - context와 초기 시간 값 전달해야 함
                          context: context,
                          initialTime: TimeOfDay(hour: 12, minute: 00),
                          // 최초 시간은 db에 저장 된 데이터가 있으면 불러오기
                        );
                        if (selectedTime != null) {
                          setState(() {
                            firstTime = selectedTime;
                          });
                        }
                      },
                      child:
                          Text('시간선택', style: TextStyle(color: Colors.white))),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        controller: _firstFood,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )))),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'g',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 228, 6, 95))),
              child: Row(
                children: [
                  Text(
                    '${secondTime.hour}:${secondTime.minute}',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () async {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          // showTimePicker - context와 초기 시간 값 전달해야 함
                          context: context,
                          initialTime: TimeOfDay(hour: 12, minute: 00),
                          // 최초 시간은 db에 저장 된 데이터가 있으면 불러오기
                        );
                        if (selectedTime != null) {
                          setState(() {
                            secondTime = selectedTime;
                          });
                        }
                      },
                      child:
                          Text('시간선택', style: TextStyle(color: Colors.white))),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        controller: _secondFood,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )))),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'g',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 228, 6, 95))),
              child: Row(
                children: [
                  Text(
                    '${thirdTime.hour}:${thirdTime.minute}',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      onPressed: () async {
                        final TimeOfDay? selectedTime = await showTimePicker(
                          // showTimePicker - context와 초기 시간 값 전달해야 함
                          context: context,
                          initialTime: TimeOfDay(hour: 12, minute: 00),
                          // 최초 시간은 db에 저장 된 데이터가 있으면 불러오기
                        );
                        if (selectedTime != null) {
                          setState(() {
                            thirdTime = selectedTime;
                          });
                        }
                      },
                      child:
                          Text('시간선택', style: TextStyle(color: Colors.white))),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        controller: _thirdFood,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                )))),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'g',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 228, 6, 95))),
              child: Column(
                children: [
                  Text('타이머4'),
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
                '설정하기',
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
