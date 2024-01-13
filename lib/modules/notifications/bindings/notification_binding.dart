import 'package:get/get.dart';
import 'package:studyhelper/data/class/class_controller.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/modules/main/main_controller.dart';
import 'package:studyhelper/modules/notifications/notification_view_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationViewController());
    Get.lazyPut(() => NotificationController());
  }
}
