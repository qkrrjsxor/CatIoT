import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/auto_check.dart';

import '../service/feeder_service.dart';

int feedcounter = 0;

class FeederAuto extends StatefulWidget {
  const FeederAuto({super.key});

  @override
  State<FeederAuto> createState() => AutoScreen();
}

class AutoScreen extends State<FeederAuto> {
  // db에 저장 된 시간이 있으면 불러오자

  final FeederService feederService = FeederService();

  TimeOfDay firstTime = TimeOfDay.now(); // 현재 시간 기준으로 시간대를 생성하는 생성자
  TimeOfDay secondTime = TimeOfDay.now();
  TimeOfDay thirdTime = TimeOfDay.now();
  TimeOfDay fourthTime = TimeOfDay.now();
  TimeOfDay fifthTime = TimeOfDay.now();

  TextEditingController _firstFood = TextEditingController();
  TextEditingController _secondFood = TextEditingController();
  TextEditingController _thirdFood = TextEditingController();
  TextEditingController _fourthFood = TextEditingController();
  TextEditingController _fifthFood = TextEditingController();

  void _incrementCounter() {
    if (feedcounter >= 0 && feedcounter < 5) {
      setState(() {
        feedcounter++;
      });
    }
  }

  void _decrementCounter() {
    if (feedcounter > 0 && feedcounter < 6) {
      setState(() {
        feedcounter--;
      });
    }
  }

  // AutoScreen();
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
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.all(5),
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
                  Text(
                    '하루 $feedcounter회',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Container(
                width: 300,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(width: 15),
                  TextButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons
                        .add), // This trailing comma makes auto-formatting nicer for build methods.
                  ),
                  TextButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons
                        .remove), // This trailing comma makes auto-formatting nicer for build methods.
                  ),
                ])
                // child: Column(
                //   children: [
                //     Text('하루 2회',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 25,
                //         )),
                //   ],
                // ),
                ),
            AbsorbPointer(
              absorbing: feedcounter < 1,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 350,
                decoration: BoxDecoration(
                    color: feedcounter < 1
                        ? Color.fromARGB(220, 67, 67, 67)
                        : Colors.white,
                    border: Border.all(
                        color: feedcounter < 1
                            ? Color.fromARGB(220, 67, 67, 67)
                            : Colors.pink)),
                child: Row(
                  children: [
                    Text(
                      '${firstTime.hour}:${firstTime.minute}',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: feedcounter < 1
                                ? Color.fromARGB(220, 67, 67, 67)
                                : Colors.pink),
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
                        child: Text('시간선택',
                            style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
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
            ),
            AbsorbPointer(
              absorbing: feedcounter < 2,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 350,
                decoration: BoxDecoration(
                    color: feedcounter < 2
                        ? Color.fromARGB(220, 67, 67, 67)
                        : Colors.white,
                    border: Border.all(
                        color: feedcounter < 2
                            ? Color.fromARGB(220, 67, 67, 67)
                            : Colors.pink)),
                child: Row(
                  children: [
                    Text(
                      '${secondTime.hour}:${secondTime.minute}',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: feedcounter < 2
                                ? Color.fromARGB(220, 67, 67, 67)
                                : Colors.pink),
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
                        child: Text('시간선택',
                            style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
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
            ),
            AbsorbPointer(
              absorbing: feedcounter < 3,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 350,
                decoration: BoxDecoration(
                    color: feedcounter < 3
                        ? Color.fromARGB(220, 67, 67, 67)
                        : Colors.white,
                    border: Border.all(
                        color: feedcounter < 3
                            ? Color.fromARGB(220, 67, 67, 67)
                            : Colors.pink)),
                child: Row(
                  children: [
                    Text(
                      '${thirdTime.hour}:${thirdTime.minute}',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: feedcounter < 3
                                ? Color.fromARGB(220, 67, 67, 67)
                                : Colors.pink),
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
                        child: Text('시간선택',
                            style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
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
            ),
            AbsorbPointer(
              absorbing: feedcounter < 4,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 350,
                decoration: BoxDecoration(
                    color: feedcounter < 4
                        ? Color.fromARGB(220, 67, 67, 67)
                        : Colors.white,
                    border: Border.all(
                        color: feedcounter < 4
                            ? Color.fromARGB(220, 67, 67, 67)
                            : Colors.pink)),
                child: Row(
                  children: [
                    Text(
                      '${fourthTime.hour}:${fourthTime.minute}',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: feedcounter < 4
                                ? Color.fromARGB(220, 67, 67, 67)
                                : Colors.pink),
                        onPressed: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            // showTimePicker - context와 초기 시간 값 전달해야 함
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 00),
                            // 최초 시간은 db에 저장 된 데이터가 있으면 불러오기
                          );
                          if (selectedTime != null) {
                            setState(() {
                              fourthTime = selectedTime;
                            });
                          }
                        },
                        child: Text('시간선택',
                            style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          controller: _fourthFood,
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
            ),
            AbsorbPointer(
              absorbing: feedcounter < 5,
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                    color: feedcounter < 5
                        ? Color.fromARGB(220, 67, 67, 67)
                        : Colors.white,
                    border: Border.all(
                        color: feedcounter < 5
                            ? Color.fromARGB(220, 67, 67, 67)
                            : Colors.pink)),
                child: Row(
                  children: [
                    Text(
                      '${fifthTime.hour}:${fifthTime.minute}',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: feedcounter < 5
                                ? Color.fromARGB(220, 67, 67, 67)
                                : Colors.pink),
                        onPressed: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            // showTimePicker - context와 초기 시간 값 전달해야 함
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 00),
                            // 최초 시간은 db에 저장 된 데이터가 있으면 불러오기
                          );
                          if (selectedTime != null) {
                            setState(() {
                              fifthTime = selectedTime;
                            });
                          }
                        },
                        child: Text('시간선택',
                            style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          controller: _fifthFood,
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
            ),

            // Container(
            //   padding: EdgeInsets.all(30),
            //   margin: EdgeInsets.all(10),
            //   width: 300,
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Color.fromARGB(255, 228, 6, 95))),
            //   child: Column(
            //     children: [
            //       Text('타이머4'),
            //     ],
            //   ),
            // ),

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
                    int? _firstmeal;
                    int? _secondmeal;
                    int? _thirdmeal;
                    int? _fourthmeal;
                    int? _fifthmeal;

                    if (feedcounter == 1 ||
                        feedcounter == 2 ||
                        feedcounter == 3 ||
                        feedcounter == 4 ||
                        feedcounter == 5) {
                      _firstmeal = int.parse(_firstFood.text);
                    } else {
                      _firstmeal = null;
                    }

                    if (feedcounter == 2 ||
                        feedcounter == 3 ||
                        feedcounter == 4 ||
                        feedcounter == 5) {
                      _secondmeal = int.parse(_secondFood.text);
                    } else {
                      _secondmeal = null;
                    }

                    if (feedcounter == 3 ||
                        feedcounter == 4 ||
                        feedcounter == 5) {
                      _thirdmeal = int.parse(_thirdFood.text);
                    } else {
                      _thirdmeal = null;
                    }

                    if (feedcounter == 4 || feedcounter == 5) {
                      _fourthmeal = int.parse(_fourthFood.text);
                    } else {
                      _fourthmeal = null;
                    }

                    if (feedcounter == 5) {
                      _fifthmeal = int.parse(_fifthFood.text);
                    } else {
                      _fifthmeal = null;
                    }

                    // if (_firstFood.text.isNotEmpty) {
                    //   _firstmeal = int.parse(_firstFood.text);
                    // } else { _firstmeal = null; }
                    //
                    // if (_secondFood.text.isNotEmpty) {
                    //   _secondmeal = int.parse(_secondFood.text);
                    // } else { _secondmeal = null; }
                    //
                    // if (_thirdFood.text.isNotEmpty) {
                    //   _thirdmeal = int.parse(_thirdFood.text);
                    // } else { _thirdmeal = null; }
                    //
                    // if (_fourthFood.text.isNotEmpty) {
                    //   _fourthmeal = int.parse(_fourthFood.text);
                    // } else { _fourthmeal = null; }
                    //
                    // if (_fifthFood.text.isNotEmpty) {
                    //   _fifthmeal = int.parse(_fifthFood.text);
                    // } else { _fifthmeal = null; }

                    // int _firstmeal = int.parse(_firstFood.text);
                    // int _secondmeal = int.parse(_secondFood.text);
                    // int _thirdmeal = int.parse(_thirdFood.text);
                    // int _fourthmeal = int.parse(_fourthFood.text);
                    // int _fifthmeal = int.parse(_fifthFood.text);

                    // DateTime firstCheck = DateTime(0,0,0, firstTime.hour, firstTime.minute);

                    await feederService.autoFeed(
                        context,
                        firstTime,
                        _firstmeal,
                        secondTime,
                        _secondmeal,
                        thirdTime,
                        _thirdmeal,
                        fourthTime,
                        _fourthmeal,
                        fifthTime,
                        _fifthmeal);

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
