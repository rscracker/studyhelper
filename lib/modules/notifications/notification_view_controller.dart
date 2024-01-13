import 'package:get/get.dart';
import 'package:studyhelper/data/notification/model/notification_model.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';

class NotificationViewController extends GetxController {
  static NotificationViewController get to =>
      Get.find<NotificationViewController>();

  final notificationController = NotificationController.to;

  List<NotificationModel> get notifications =>
      notificationController.notifications;
}
