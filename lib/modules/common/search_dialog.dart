import 'package:flutter/material.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/utils/app_color.dart';

class SearchDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController nickController;
  final Function({required bool isNick}) onSearch;

  const SearchDialog(
      {required this.nameController,
      required this.nickController,
      required this.onSearch,
      Key? key})
      : super(key: key);

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
                decoration: const InputDecoration(
                  focusColor: AppColor.mainColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              onPressed: () {
                onSearch(isNick: false);
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
                decoration: const InputDecoration(
                  focusColor: AppColor.mainColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              onPressed: () => onSearch(isNick: true),
              buttonColor: AppColor.mainColor,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
