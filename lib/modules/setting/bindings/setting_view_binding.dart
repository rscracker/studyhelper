import 'package:get/get.dart';
import 'package:studyhelper/modules/setting/setting_view_controller.dart';

class SettingViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingViewController());
  }
}
