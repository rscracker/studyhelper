import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/services/user_service.dart';

class LoginViewController extends GetxController {
  static LoginViewController get to => Get.find<LoginViewController>();

  final userService = UserService.to;

  TextEditingController get phoneNumController =>
      userService.phoneNumController;
  TextEditingController get authNumController => userService.authNumController;

  @override
  void onInit() {
    userService.autoLogin();
    super.onInit();
  }

  void onSend() {
    if (phoneNumController.text.length == 11) {
      userService.smsAuth();
    }
  }

  void onAuth() {
    userService.signInWithPhoneNumber();
  }
}
