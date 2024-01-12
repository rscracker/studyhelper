import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/main/main_view.dart';
import 'package:studyhelper/utils/app_color.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final userService = UserService.to;

  @override
  void initState() {
    userService.autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Study Helper',
              style: GoogleFonts.alegreyaSc(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            _Item(
              category: '전화번호',
              controller: userService.phoneNumController,
              buttonText: '인증번호 발송',
              maxLength: 11,
              onPressed: () async {
                await userService.smsAuth();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _Item(
              category: '인증번호',
              controller: userService.authNumController,
              maxLength: 6,
              buttonText: '인증하기',
              onPressed: () async {
                await userService.signInWithPhoneNumber();
              },
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Row(
            //   children: [
            //     Icon(Icons.check_box_outline_blank_rounded),
            //     const SizedBox(
            //       width: 7,
            //     ),
            //     Text('자동 로그인'),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String category;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final String buttonText;
  final int maxLength;

  const _Item(
      {required this.category,
      required this.controller,
      required this.onPressed,
      required this.buttonText,
      required this.maxLength,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: '',
            suffixIcon: TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xff3478f6),
                ),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.defaultColor2),
            ),
          ),
        )
      ],
    );
  }
}
