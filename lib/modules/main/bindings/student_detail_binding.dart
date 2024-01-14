import 'package:get/get.dart';
import 'package:studyhelper/modules/main/bindings/student_detail_view_controller.dart';
import 'package:studyhelper/modules/main/student_detail.dart';

class StudnetDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentDetailViewController());
  }
}
