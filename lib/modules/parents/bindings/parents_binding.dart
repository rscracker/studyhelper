import 'package:get/get.dart';
import 'package:studyhelper/data/class/class_controller.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/modules/parents/parents_controller.dart';

class ParentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParentsController());
    Get.lazyPut(() => ClassController());
    Get.lazyPut(() => NotificationController());
  }
}
