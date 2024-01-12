import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class ClassDialog extends StatefulWidget {
  const ClassDialog({Key? key}) : super(key: key);

  @override
  State<ClassDialog> createState() => _ClassDialogState();
}

class _ClassDialogState extends State<ClassDialog> {
  DateTime classDate = DateTime.now();

  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('class');

  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: Text(
          '수업 개설하기',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            '과목',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          TextField(
            controller: subjectController,
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
            height: 50,
            text: '수업 개설',
            onPressed: () async {
              String classId = classCollection.doc().id;
              await classCollection.doc(classId).set(ClassModel(
                    classId: classId,
                    className: '',
                    subject: subjectController.text,
                    date: classDate,
                    time: 1800,
                    teacherId: UserService.to.currentUser.uid,
                    studentId: List.empty(),
                    duration: 180,
                    parentsId: List.empty(),
                  ).toJson());
              Get.back();
            },
            buttonColor: AppColor.mainColor,
          )
        ],
      ),
    );
  }
}
