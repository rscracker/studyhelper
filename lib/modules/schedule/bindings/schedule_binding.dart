import 'package:get/get.dart';
import 'package:studyhelper/modules/schedule/scheuld_view_controller.dart';

class ScheduleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleViewController());
  }
}
