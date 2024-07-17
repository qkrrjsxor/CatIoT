import 'package:flutter/material.dart';
import 'package:untitled/screens/login.dart';
import 'package:untitled/screens/catscreen.dart';
import 'package:untitled/screens/health.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ★ 로그인 상태이면 WelcomeScreen 대신 MainScreen으로 바로 이동
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        '/health': (context) => Health(),
        '/catview': (context) => CatScreen()
      },
      home: Login(),
    );
  }
}
