import 'package:get/get.dart';
import 'package:studyhelper/data/friends/friends_controller.dart';
import 'package:studyhelper/data/notification/model/notification_model.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';

class NotificationViewController extends GetxController {
  static NotificationViewController get to =>
      Get.find<NotificationViewController>();

  final notificationController = NotificationController.to;
  //final friendsController = FriendsController.to;
  final userService = UserService.to;

  UserModel get currentUser => userService.currentUser;

  List<NotificationModel> get notifications =>
      notificationController.notifications;

  void responseRequset(
      {required bool isAccepted, required NotificationModel notification}) {
    notificationController.deleteNotification(notification: notification);
    userService.responseFriend(
      isAccepted: isAccepted,
      notification: notification,
    );
  }
}
