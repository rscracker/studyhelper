import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/friends/friends_controller.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/modules/common/search_result_dialog.dart';
import 'package:studyhelper/services/user_service.dart';

class FriendsViewController extends GetxController {
  static FriendsViewController get to => Get.find<FriendsViewController>();

  //final friendsController = FriendsController.to;
  final notificationController = NotificationController.to;
  final userService = UserService.to;

  UserModel get currentUser => userService.currentUser;

  final TextEditingController searchController = TextEditingController();
  List<UserModel> get friends => userService.friends;

  @override
  void onInit() {
    userService.getFriends(myUid: currentUser.uid);
    super.onInit();
  }

  void onSearch() async {
    List<UserModel> searchedUsers = await userService.findUsers(
        isNick: true, nameOrNick: searchController.text);

    if (searchedUsers.isNotEmpty) {
      Get.dialog(SearchResultDialog(
        users: searchedUsers,
        onSendFriendRequest: onSendFriendRequest,
      ));
    } else {
      Get.dialog(
          CustomDialog(text: '검색 결과가 없습니다.', onPressed: () => Get.back()));
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
}
