import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/logincheck.dart';

import 'package:table_calendar/table_calendar.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => HealthScreen();
}

class Event {
  String title;
  String record;

  Event({required this.title, required this.record});

  @override
  String toString() {
    return '$title $record';
  }
}

class HealthScreen extends State<Health> {
  var _selectedEvents = ValueNotifier<List<Event>>([]);

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _calendarFormat: CalendarFormat.month;
    _selectedEvents.value = _getEventsForDay(_selectedDay!);

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // 임시로 정한 데이터 - 나중에 요청 후 저장된 데이터 불러와서 표시해야 함
  Map<DateTime, List<Event>> kEvents = {
    DateTime(2024, 7, 13): [
      Event(title: '13일 식사', record: '3회'),
      Event(title: '13일 배변', record: '3회'),
      Event(title: '13일 건강', record: '좋음'),

    ],
    DateTime(2024, 7, 14): [
      Event(title: '14일 식사', record: '1회'),
      Event(title: '14일 배변', record: '2회'),
      Event(title: '14일 건강', record: '보통'),
    ],
    DateTime(2024, 7, 27): [
      Event(title: '27일 식사', record: '3회'),
      Event(title: '27일 배변', record: '1회'),
      Event(title: '27일 건강', record: '아주 좋음'),
    ],
  };

  // 실행 안 되고 있음 최초에서만 실행
  List<Event> _getEventsForDay(DateTime _selectedDay) {
    return kEvents[DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)] ?? [];
  }

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
              '우리 ${CatInfo![0]['catName']}의 건강 상태는?',

              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            TableCalendar(
              firstDay: DateTime.utc(2024, 07, 01),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay, // 날짜 밑 점 표시
              // 해당 날짜가 선택 가능한지 여부를 결정
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              //날짜가 실제로 선택되었을 때 실행되는 함수
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents.value = _getEventsForDay(_selectedDay!);

                });
              },

              // 날짜가 월 단위, 년도 단위로 변경될 때 실행
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

            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      bool clicks = index != 1;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () =>
                              print('${value[index]}'),

                              title: clicks ? Text('${value[index]}, $index') : Text('${value[index]}, $index, 냠냠냠'),
                      subtitle: Text('bbb'),
                      // child: ListTile(
                      // onTap: () => print('${value[index]}'),
                      // title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
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
