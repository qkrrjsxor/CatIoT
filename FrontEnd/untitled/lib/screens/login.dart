import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/signup.dart';
import 'package:untitled/screens/logincheck.dart';

class LoginScreen extends StatelessWidget {
  final LoginCheck loginCheck = LoginCheck();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
              child: Column(
                children: [
                  Text('Cat IoT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                  const SizedBox(height: 45.0),
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
                      controller: userController,
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
                      controller: passwordController,
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
                    onPressed: () async {
                      // 로그인 했을 때 조건 (검증, db 저장, 토큰)
                      await loginCheck.login(
                        userController.text,
                        passwordController.text,
                      );
                      print(userController.text);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ));
                    },
                    child: Text('로그인', style: TextStyle(color: Colors.white)),
                  ),

                  const SizedBox(height: 16.0),

                  Row(
                    children: [
                      Text(
                        '아직 회원이 아니라면?',
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 145, 145, 145),
                          height: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          print(Navigator);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ));
                        },
                        child: Text('회원가입',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              height: 1,
                            )),
                      ),
                    ],
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
