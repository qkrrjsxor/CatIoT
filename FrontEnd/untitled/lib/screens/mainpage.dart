import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/catscreen.dart';
import 'package:untitled/screens/health.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/feeder_manual.dart';
import 'package:untitled/screens/feeder_auto.dart';
import 'package:untitled/screens/logincheck.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final LoginCheck loginCheck = LoginCheck();
  String? selectedCatName; // 선택된 고양이 이름을 저장할 변수

  TimeOfDay _firstTimeCheck = TimeOfDay(hour: 12, minute: 0); // 현재 시간 기준으로 시간대를 생성하는 생성자
  TimeOfDay _secondTimeCheck = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _thirdTimeCheck = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _fourthTimeCheck = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _fifthTimeCheck = TimeOfDay(hour: 12, minute: 0);

  var _firstFoodCheck = '';
  var _secondFoodCheck = '';
  var _thirdFoodCheck = '';
  var _fourthFoodCheck = '';
  var _fifthFoodCheck = '';

  @override
  void initState() {
    super.initState();
    // 처음에 선택된 고양이 이름 설정
    if (CatInfo != null && CatInfo!.isNotEmpty) {
      selectedCatName = CatInfo![0]['catName'];
    }
    _loadSchedule();
  }



  _loadSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // firstTime = stringToTimeOfDay(prefs.getString("scheduleTime1"));
      try{
        feedcounter = prefs.getInt("scheduleCount")!;
      }catch(error){
        feedcounter = 0;
      }

      if(feedcounter == 0){

      }else {
        if(feedcounter >= 1){
          _firstTimeCheck = stringToTimeOfDay(prefs.getString("scheduleTime1")!);
          _firstFoodCheck = prefs.getInt("scheduleAmount1").toString();
        }
        if(feedcounter >= 2){
          _secondTimeCheck = stringToTimeOfDay(prefs.getString("scheduleTime2")!);
          _secondFoodCheck = prefs.getInt("scheduleAmount2").toString();
        }
        if(feedcounter >= 3){
          _thirdTimeCheck = stringToTimeOfDay(prefs.getString("scheduleTime3")!);
          _thirdFoodCheck = prefs.getInt("scheduleAmount3").toString();
        }
        if(feedcounter >= 4){
          _fourthTimeCheck = stringToTimeOfDay(prefs.getString("scheduleTime4")!);
          _fourthFoodCheck = prefs.getInt("scheduleAmount4").toString();
        }
        if(feedcounter >= 5){
          _fifthTimeCheck = stringToTimeOfDay(prefs.getString("scheduleTime5")!);
          _fifthFoodCheck = prefs.getInt("scheduleAmount5").toString();
        }
      }
    });
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
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
              decoration: BoxDecoration(color:Color.fromARGB(223, 255, 219, 224),
                  // border: Border.all(color: Colors.blue),
                  borderRadius:BorderRadius.circular(20)),
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
                        // Text('$firstFood'),
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
              decoration: BoxDecoration(color:Color.fromARGB(223, 255, 219, 224),
                  // border: Border.all(color: Colors.blue),
                  borderRadius:BorderRadius.circular(20)),
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
              decoration: BoxDecoration(color:Color.fromARGB(223, 255, 219, 224),
                  // border: Border.all(color: Colors.blue),
                  borderRadius:BorderRadius.circular(20)),

              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('자동 배급 - 하루 $feedcounter회',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize:17)),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.pink),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color:Colors.black,
                    thickness:1,
                    height:10,
                  ),

                  SizedBox(height:10),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width:62,
                          child:Column(
                            children:[
                              Container(height:30,child:Text('1',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)),),
                              Container(height:30,
                                child: feedcounter >= 1 ? Text('${_firstTimeCheck.hour.toString().padLeft(2,'0')}:${_firstTimeCheck.minute.toString().padLeft(2,'0')}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Icon(Icons.pets),),),
                              Container(height:30, child: feedcounter >= 1 ? Text('$_firstFoodCheck g',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Text(''),)),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          child:Row(
                            children: [
                              VerticalDivider(
                                color:Colors.black,
                                thickness:1,
                                // width:30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:62,
                          child:Column(
                            children:[
                              Container(height:30,child:Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)),),
                              Container(height:30,
                                  child: feedcounter >= 2 ? Text('${_secondTimeCheck.hour.toString().padLeft(2,'0')}:${_secondTimeCheck.minute.toString().padLeft(2,'0')}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Icon(Icons.pets),)),
                              Container(height:30,child: feedcounter >= 2  ? Text('$_secondFoodCheck g',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Text(''),)),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          child:Row(
                            children: [
                              VerticalDivider(
                                color:Colors.black,
                                thickness:1,
                                // width:30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:62,
                          child:Column(
                            children:[
                              Container(height:30,child:Text('3', style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)),),
                              Container(height:30,
                                  child: feedcounter >= 3 ? Text('${_thirdTimeCheck.hour.toString().padLeft(2,'0')}:${_thirdTimeCheck.minute.toString().padLeft(2,'0')}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Icon(Icons.pets),)),
                              Container(height:30,child: feedcounter >= 3  ? Text('$_thirdFoodCheck g',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Text(''),)),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          child:Row(
                            children: [
                              VerticalDivider(
                                color:Colors.black,
                                thickness:1,
                                // width:30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:62,
                          child:Column(
                            children:[
                              Container(height:30,child:Text('4',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)),),
                              Container(height:30,
                                  child: feedcounter >= 4 ? Text('${_fourthTimeCheck.hour.toString().padLeft(2,'0')}:${_fourthTimeCheck.minute.toString().padLeft(2,'0')}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Icon(Icons.pets),)),
                              Container(height:30,child: feedcounter >= 4  ? Text('$_fourthFoodCheck g',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Text(''),)),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          child:Row(
                            children: [
                              VerticalDivider(
                                color:Colors.black,
                                thickness:1,
                                // width:30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:62,
                          child:Column(
                            children:[
                              Container(height:30,child:Text('5',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17)),),
                              Container(height:30,
                                  child: feedcounter >= 5 ? Text('${_fifthTimeCheck.hour.toString().padLeft(2,'0')}:${_fifthTimeCheck.minute.toString().padLeft(2,'0')}',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Icon(Icons.pets),)),
                              Container(height:30,child: feedcounter >= 5  ? Text('$_fifthFoodCheck g',  style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)) : Container(child:Text(''),)),
                            ],
                          ),
                        ),

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
              decoration: BoxDecoration(color:Color.fromARGB(223, 255, 219, 224),
                  // border: Border.all(color: Colors.blue),
                  borderRadius:BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('수동 배급',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize:17,)),
                        Text('  고양이에게 직접 밥을 주러 갑시다'),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
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
