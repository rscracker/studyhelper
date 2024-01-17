import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyhelper/services/user_service.dart';

class SettingViewController extends GetxController {
  static SettingViewController get to => Get.find<SettingViewController>();

  final userService = UserService.to;

  void onLogOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', '');
    Get.offAllNamed('/login');
  }

  void onSignOut() {}
}
