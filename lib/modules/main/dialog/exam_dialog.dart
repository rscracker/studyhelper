import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class ExamDialog extends StatefulWidget {
  ExamDialog({Key? key}) : super(key: key);

  @override
  State<ExamDialog> createState() => _ExamDialogState();
}

class _ExamDialogState extends State<ExamDialog> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String type = '';

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
              '시험 일정 추가',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              '날짜',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
                      todoDate = selectedDate;
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
                    Utils.convertDate(date: todoDate),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '시험 유형',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                        visualDensity: VisualDensity(horizontal: -4),
                        value: '중간고사',
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = '중간고사';
                          });
                        }),
                    Text('중간고사'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        visualDensity: VisualDensity(horizontal: -4),
                        value: '기말고사',
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = '기말고사';
                          });
                        }),
                    Text('기말고사'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        visualDensity: VisualDensity(horizontal: -4),
                        value: '모의고사',
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = '모의고사';
                          });
                        }),
                    Text('모의고사'),
                  ],
                )
              ],
            ),
            if (type == '중간고사' || type == '기말고사')
              _Item(controller: subjectController, title: '과목'),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 35,
            ),
            CustomButton(
                buttonColor: AppColor.mainColor,
                text: '추가',
                onPressed: () async {
                  todoService.addExam(
                      date: todoDate,
                      type: type,
                      subject: subjectController.text);
                  Get.back();
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
        TextField(
          controller: controller,
        ),
      ],
    );
  }
}
