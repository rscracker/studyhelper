import 'package:get/get.dart';
import 'package:studyhelper/modules/history/history_view_controller.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryViewController());
    // TODO: implement dependencies
  }
}
