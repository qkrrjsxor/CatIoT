import 'package:flutter/material.dart';
import 'package:untitled/screens/mainpage.dart';
import 'package:untitled/screens/signupcheck.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => SignupStateScreen();
}

class SignupStateScreen extends State<Signup> {
  final SignupCheck signupCheck = SignupCheck();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController catNameController = TextEditingController();
  TextEditingController catGenderController = TextEditingController();
  TextEditingController catAgeController = TextEditingController();

  bool userConfirm = false;
  bool passwordConfirm = false;
  bool passwordCheckConfirm = false;
  bool catNameConfirm = false;
  bool catGenderConfirm = false;
  bool catAgeConfirm = false;

  final List<String> genderOption = ['male', 'female'];

  String? selectedGender;

  // 정규식
  final RegExp userRegExp = RegExp(r'^[a-zA-Z0-9]{4,}$');
  final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');

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
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('아이디 (4글자 이상)',
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                  ),
                  Visibility(
                    visible: userConfirm,
                    child: Text(
                      '아이디는 4글자 이상으로 영어와 숫자만 가능합니다',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호 (영문 대소문자, 숫자, 특수문자 포함)',
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                  ),
                  Visibility(
                    visible: passwordConfirm,
                    child: Text(
                      '6글자 이상으로 영문, 숫자, 특수문자를 포함하여야 합니다',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
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
                    controller: passwordCheckController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                  ),
                  Visibility(
                    visible: passwordCheckConfirm,
                    child: Text(
                      '비밀번호가 일치하지 않습니다',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('고양이 이름 (최대 6글자)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                    controller: catNameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                  ),
                  Visibility(
                    visible: catNameConfirm,
                    child: Text(
                      '고양이 이름은 최대 6글자 까지 가능합니다',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('고양이 성별 (택1)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  DropdownButtonFormField<String>(
                    // controller: catGenderController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                    items: genderOption.map((String option) {
                      return DropdownMenuItem<String>(
                        value:option,
                        child:Text(option),
                      );
                    }).toList(),
                    onChanged:(String? genderAnswer) {
                      setState(() {
                        selectedGender = genderAnswer;
                        if (selectedGender == 'male') {
                          catGenderController.text = 'male';
                        } else if (selectedGender == 'female') {
                          catGenderController.text = 'female';
                        }

                      });
                    },
                    value:selectedGender,
                  ),

                  Visibility(
                    visible: catGenderConfirm,
                    child: Text(
                      'male 또는 female로 선택해야 합니다',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('고양이 나이 (숫자로만 입력해주세요)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8.0), // 여백
                  TextFormField(
                    controller: catAgeController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(223, 197, 197, 197),
                                width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color.fromARGB(223, 197, 197, 197),
                            ))),
                  ),
                  Visibility(
                    visible: catAgeConfirm,
                    child: Text(
                      '고양이 나이는 숫자만 입력해주세요',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
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
                      setState(() {
                        userConfirm = !userRegExp.hasMatch(userController.text);
                        passwordConfirm = !passwordRegExp.hasMatch(passwordController.text);
                        passwordCheckConfirm = passwordController.text != passwordCheckController.text;
                        catNameConfirm = catNameController.text.length > 6;
                        catGenderConfirm = catGenderController.text != 'male' && catGenderController.text != 'female';
                        catAgeConfirm = int.tryParse(catAgeController.text) == null;
                      });

                      if (userConfirm == false &&
                          passwordConfirm == false &&
                          passwordCheckConfirm == false &&
                          catNameConfirm == false &&
                          catGenderConfirm == false &&
                          catAgeConfirm == false) {
                        await signupCheck.signup(
                          context,
                          userController.text,
                          passwordController.text,
                          catNameController.text,
                          catGenderController.text,
                          catAgeController.text,
                        );

                      }
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
