import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/services/user_service.dart';

class LoginViewController extends GetxController {
  static LoginViewController get to => Get.find<LoginViewController>();

  final userService = UserService.to;

  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController authNumController = TextEditingController();

  @override
  void onInit() {
    userService.autoLogin();
    super.onInit();
  }

  void onSend() async {
    print('+82${phoneNumController.text.substring(1, 11)}');
    if (phoneNumController.text.length == 11) {
      await userService.smsAuth(
          phoneNum: '+82${phoneNumController.text.substring(1, 11)}');
    }
  }

  void onAuth() {
    userService.signInWithPhoneNumber(
      authNum: authNumController.text,
      phoneNum: phoneNumController.text,
    );
  }
}
