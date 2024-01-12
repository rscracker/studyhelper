import 'package:get/get.dart';
import 'package:studyhelper/data/class/class_controller.dart';
import 'package:studyhelper/modules/main/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => ClassController());
  }
}
