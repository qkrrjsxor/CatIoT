import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 199, 195, 200))),
              child: Column(
                children: [
                  Text('회원가입',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('아이디',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                              )))),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                              )))),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호 확인',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                              )))),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('고양이 이름',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                              )))),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('고양이 성별',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(223, 197, 197, 197),
                                  width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                              )))),
                  const SizedBox(height: 8.0),

                  const SizedBox(height: 16.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: Size(350, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // 로그인 했을 때 조건 (검증, db 저장, 토큰)
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ));
                    },
                    child:
                        Text('회원가입 완료', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
