import 'package:get/get.dart';
import 'package:studyhelper/data/friends/friends_controller.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/modules/friends/friends_view_controller.dart';

class FriendsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendsViewController());
    //Get.lazyPut(() => FriendsController());
    Get.lazyPut(() => NotificationController());
  }
}
