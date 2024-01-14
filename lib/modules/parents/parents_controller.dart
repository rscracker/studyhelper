import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/class_controller.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/modules/common/search_result_dialog.dart';
import 'package:studyhelper/services/user_service.dart';

class ParentsController extends GetxController {
  static ParentsController get to => Get.find<ParentsController>();

  final userService = UserService.to;
  final classController = ClassController.to;
  final notificationController = NotificationController.to;

  UserModel get currentUser => userService.currentUser;
  List<ClassModel> get classes => classController.classes;
  List<UserModel> get friends => userService.friends;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickController = TextEditingController();

  @override
  void onInit() {}

  Future<void> onSearch({required bool isNick}) async {
    final RxList<UserModel> result = RxList.empty();
    if (isNick && nickController.text.isNotEmpty) {
      result.assignAll(await userService.findUsers(
          isNick: true, nameOrNick: nickController.text));
    } else if (!isNick && nameController.text.isNotEmpty) {
      result.assignAll(await userService.findUsers(
          isNick: true, nameOrNick: nameController.text));
    }

    if (result.isEmpty) {
      Get.dialog(
          CustomDialog(text: '검색 결과가 없습니다', onPressed: () => Get.back()));
    } else {
      nickController.text = '';
      nameController.text = '';
      Get.back();
      Get.dialog(SearchResultDialog(
        users: result,
        onSendFriendRequest: onSendFriendRequest,
      ));
    }
  }

  void onSendFriendRequest({
    required UserModel user,
  }) async {
    await notificationController.addNotifcation(
        receiver: user,
        content: '${user.name}님의 친구 요청이 있습니다.',
        myUid: currentUser.uid,
        type: 'friendRequest');
    Get.back();
    Get.dialog(
        CustomDialog(text: '친구 요청이 완료되었습니다.', onPressed: () => Get.back()));
  }

  void onPressedNotification() {
    Get.toNamed('/notification');
  }

  void onPressedStudentDetail({required UserModel user}) {
    Get.toNamed('/studentDetail', arguments: user);
  }
}
