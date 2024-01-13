import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/notification/model/notification_model.dart';
import 'package:studyhelper/modules/notifications/notification_view_controller.dart';
import 'package:studyhelper/services/notification_service.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/utils/app_color.dart';

class NotificationView extends GetView<NotificationViewController> {
  NotificationView({Key? key}) : super(key: key);

  final userService = UserService.to;
  final notificationService = NotificationService.to;
  UserModel get user => userService.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            '알림',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColor.mainColor,
          elevation: 0,
        ),
        body: Obx(() => controller.notifications.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '알림이 없습니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ))
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                      List.generate(controller.notifications.length, (index) {
                    return _item(notification: controller.notifications[index]);
                  }),
                ),
              )));
  }

  Widget _item({required NotificationModel notification}) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(
            notification.content,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (notification.type == 'friendRequest')
            CustomButton(
              text: '승인',
              onPressed: () {
                // UserService.to.responseFriend(
                //     isAccepted: true, notification: notification);
              },
              width: 60,
              height: 30,
              buttonColor: AppColor.mainColor,
            ),
          const SizedBox(
            width: 10,
          ),
          if (notification.type == 'friendRequest')
            CustomButton(
              text: '거절',
              onPressed: () {
                // UserService.to.responseFriend(
                //     isAccepted: false, notification: notification);
              },
              width: 60,
              height: 30,
              buttonColor: AppColor.mainColor,
            ),
        ],
      ),
    );
  }
}
