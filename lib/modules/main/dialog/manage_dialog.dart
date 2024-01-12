import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class ManageDialog extends StatefulWidget {
  final ClassModel classItem;
  ManageDialog({required this.classItem, Key? key}) : super(key: key);

  @override
  State<ManageDialog> createState() => _ManageDialogState();
}

class _ManageDialogState extends State<ManageDialog> {
  final TextEditingController searchController = TextEditingController();

  UserModel student = UserModel.initUser();

  ClassModel get classItem => widget.classItem;

  DateTime classDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Column(
        children: [
          Text(classItem.subject),
          Text(
            '${Utils.convertDate(date: classItem.date)} ${(classItem.time ~/ 100).toString()}:${(classItem.time % 100).toString().padLeft(2, '0')}~${(classItem.time ~/ 100 + (classItem.duration ~/ 60)).toString()}:${(classItem.time % 100).toString().padLeft(2, '0')}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColor.defaultTextColor,
            ),
          )
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '학생 추가',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
                suffixIcon: CustomButton(
              width: 50,
              buttonColor: Colors.transparent,
              onPressed: () async {
                await UserService.to.findUser(nick: searchController.text);
              },
              text: '검색',
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '날짜',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 1, 1),
                  lastDate: DateTime(DateTime.now().year + 1, 12),
                  builder: (context, picker) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white,
                          surface: Colors.pink,
                          onSurface: Colors.yellow,
                        ),
                        dialogBackgroundColor: Colors.green[900],
                      ),
                      child: picker!,
                    );
                  }).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    classDate = selectedDate;
                  });
                }
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: AppColor.defaultColor2),
                color: Colors.transparent,
              ),
              child: Center(
                child: Text(
                  Utils.convertDate(date: classDate),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
              buttonColor: AppColor.mainColor,
              text: '확인',
              onPressed: () async {
                await TodoService.to
                    .changeClass(item: classItem.copyWith(date: classDate));
                Get.back();
              })
        ],
      ),
    );
  }
}
