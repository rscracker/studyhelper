import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/modules/common/search_result_dialog.dart';
import 'package:studyhelper/utils/app_color.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '검색',
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
            const Text(
              '이름 검색',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: nameController,
                cursorColor: AppColor.mainColor,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusColor: AppColor.mainColor,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: '검색',
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  final result = await UserService.to.findUsers(
                      isNick: false, nameOrNick: nameController.text);
                  if (result.isEmpty) {
                    Get.dialog(CustomDialog(
                        text: '검색 결과가 없습니다', onPressed: () => Get.back()));
                  } else {
                    Get.back();
                    //Get.dialog(SearchResultDialog(users: result));
                  }
                }
              },
              buttonColor: AppColor.mainColor,
              height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '닉네임 검색',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: nickController,
                cursorColor: AppColor.mainColor,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  focusColor: AppColor.mainColor,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: '검색',
              onPressed: () async {
                if (nickController.text.isNotEmpty) {
                  final result = await UserService.to.findUsers(
                      isNick: false, nameOrNick: nickController.text);
                  if (result.isEmpty) {
                    Get.dialog(CustomDialog(
                        text: '검색 결과가 없습니다', onPressed: () => Get.back()));
                  } else {
                    Get.back();
                    //Get.dialog(SearchResultDialog(users: result));
                  }
                }
              },
              buttonColor: AppColor.mainColor,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
