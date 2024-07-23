import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:table_calendar/table_calendar.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => HealthScreen();
}

class HealthScreen extends State<Health> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
            SizedBox(height: 40),
            Text(
              '우리 고양이의 건강 상태는?',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            TableCalendar(
              firstDay: DateTime.utc(2024, 07, 01),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              // focusedDay: DateTime.now(),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              // locale: 'ko,KR',
            ),
            // Container(
            //   padding: EdgeInsets.all(30),
            //   margin: EdgeInsets.all(10),
            //   width: 300,
            //   decoration:
            //       BoxDecoration(border: Border.all(color: Colors.green)),
            //   child: Column(
            //     children: [
            //       Text('식사 기록 - 그래프'),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(30),
            //   margin: EdgeInsets.all(10),
            //   width: 300,
            //   decoration:
            //       BoxDecoration(border: Border.all(color: Colors.green)),
            //   child: Column(
            //     children: [
            //       Text('배변 기록 - 그래프'),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(30),
            //   margin: EdgeInsets.all(10),
            //   width: 300,
            //   decoration:
            //       BoxDecoration(border: Border.all(color: Colors.green)),
            //   child: Column(
            //     children: [
            //       Text('주간 종합 평가: 양호'),
            //     ],
            //   ),
            // ),
            // TextButton(
            //     style: TextButton.styleFrom(backgroundColor: Colors.pink),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => MainScreen(),
            //           ));
            //     },
            //     child: Text(
            //       '메인으로 돌아가기',
            //       style: TextStyle(color: Colors.white),
            //     ))
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
