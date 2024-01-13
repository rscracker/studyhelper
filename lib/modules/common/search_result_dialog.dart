import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/notification/notification_controller.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/utils/app_color.dart';

class SearchResultDialog extends StatelessWidget {
  final List<UserModel> users;
  final Function({required UserModel user}) onSendFriendRequest;
  SearchResultDialog(
      {required this.users, required this.onSendFriendRequest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '검색 결과',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(users.length, (index) {
              return _item(users[index]);
            })
          ],
        ),
      ),
    );
  }

  Widget _item(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              user.nick,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
        CustomButton(
          text: '추가',
          onPressed: () => onSendFriendRequest(user: user),
          buttonColor: AppColor.mainColor,
          height: 40,
          width: 60,
        ),
      ],
    );
  }
}
