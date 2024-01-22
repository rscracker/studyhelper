import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class TodoDialog extends StatefulWidget {
  TodoDialog({Key? key}) : super(key: key);

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController todoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final TextEditingController hourController = TextEditingController();
  final TextEditingController minController = TextEditingController();

  final todoService = TodoService.to;

  DateTime todoDate = DateTime.now();

  @override
  void onInit() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '할 일 추가',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '날짜',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
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
                            primary: AppColor.mainColor,
                            onPrimary: Colors.white,
                            surface: AppColor.mainColor,
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.grey,
                        ),
                        child: picker!,
                      );
                    }).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      todoDate = selectedDate;
                    });
                  }
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: AppColor.mainColor),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    Utils.convertDate(date: todoDate),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _Item(controller: subjectController, title: '과목'),
            const SizedBox(
              height: 20,
            ),
            _Item(controller: todoController, title: '할 일'),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                buttonColor: AppColor.mainColor,
                text: '추가',
                onPressed: () async {
                  if (todoController.text.isEmpty ||
                      subjectController.text.isEmpty) {
                    Get.dialog(CustomDialog(
                        text: '모두 입력해주세요',
                        onPressed: () {
                          Get.back();
                        }));
                  } else {
                    await todoService.createTodo(
                      subject: subjectController.text,
                      todo: todoController.text,
                      date: todoDate,
                    );
                    Get.back();
                  }
                })
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool? enabled;
  const _Item(
      {required this.controller, required this.title, this.enabled, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
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
      ],
    );
  }
}
