import 'package:get/get.dart';
import 'package:studyhelper/modules/login/login_view_controller.dart';
import 'package:studyhelper/services/notification_service.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/services/user_service.dart';

class LoginViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.put(TodoService());
    Get.put(NotificationService());
    Get.lazyPut(() => LoginViewController());
  }
}
