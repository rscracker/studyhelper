import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/main/main_view.dart';
import 'package:studyhelper/utils/app_color.dart';

enum UserType { student, parents, teacher }

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nickController = TextEditingController();

  final userService = UserService.to;

  bool isNickAvailable = false;
  bool isEnabled = false;
  String nickErrorMessage = '';

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  UserType type = UserType.student;

  String convertType({required UserType type}) {
    switch (type) {
      case UserType.student:
        return '학생';
      case UserType.parents:
        return '학부모';
      case UserType.teacher:
        return '선생님';
    }
  }

  bool isChecked() {
    return nameController.text.isNotEmpty &&
        ageController.text.length == 4 &&
        isNickAvailable;
  }

  Future<bool> checkNick() async {
    QuerySnapshot snapshot = await userCollection.get();
    for (var e in snapshot.docs) {
      UserModel nowUser = UserModel.fromJson(e.data() as Map<String, dynamic>);
      if (nowUser.nick == nickController.text) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  Future<void> setUser() async {
    userService.currentUser = userService.currentUser.copyWith(
      name: nameController.text,
      nick: nickController.text,
      age: int.parse(ageController.text),
      isRegistered: true,
    );
    await userCollection
        .doc(userService.currentUser.uid)
        .set(userService.currentUser.toJson());
  }

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        isEnabled = isChecked();
      });
    });
    ageController.addListener(() {
      setState(() {
        isEnabled = isChecked();
      });
    });
    nickController.addListener(() {
      setState(() {
        isNickAvailable = false;
        nickErrorMessage = '';
        isEnabled = isChecked();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
        text: '등록하기',
        onPressed: isEnabled
            ? () async {
                await setUser();
                Get.off(() => MainView());
              }
            : () {},
        borderRadius: 0,
        buttonColor: isEnabled ? AppColor.mainColor : AppColor.defaultColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              '정보 등록',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              '가입 유형 선택',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        value: UserType.student,
                        groupValue: type,
                        activeColor: AppColor.mainColor,
                        visualDensity: VisualDensity(horizontal: -4),
                        onChanged: (value) {
                          setState(() {
                            type = UserType.student;
                          });
                        }),
                    Text('학생')
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Radio(
                        value: UserType.parents,
                        groupValue: type,
                        activeColor: AppColor.mainColor,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        onChanged: (value) {
                          setState(() {
                            type = UserType.parents;
                          });
                        }),
                    Text('학부모')
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Radio(
                        value: UserType.teacher,
                        groupValue: type,
                        activeColor: AppColor.mainColor,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        onChanged: (value) {
                          setState(() {
                            type = UserType.teacher;
                          });
                        }),
                    Text('선생님')
                  ],
                ),
              ],
            ),
            Text(
              '이름',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '출생년도',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(counterText: ''),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '닉네임',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            TextField(
              controller: nickController,
              maxLength: 10,
              decoration: InputDecoration(
                  counterText: '',
                  suffixIcon: CustomButton(
                    width: 80,
                    height: 20,
                    onPressed: () async {
                      bool result = await checkNick();
                      if (result) {
                        setState(() {
                          isNickAvailable = true;
                          nickErrorMessage = '사용가능한 닉네임입니다.';
                          isEnabled = isChecked();
                        });
                      } else {
                        setState(() {
                          isNickAvailable = false;
                          nickErrorMessage = '사용 불가능한 닉네임입니다.';
                          isEnabled = isChecked();
                        });
                      }
                    },
                    text: '중복 확인',
                    buttonColor: AppColor.mainColor,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              nickErrorMessage,
              style: TextStyle(
                  color: isNickAvailable ? Colors.green : Colors.redAccent),
            ),
          ]),
        ),
      ),
    );
  }
}
