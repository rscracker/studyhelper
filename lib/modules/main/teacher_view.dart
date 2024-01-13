import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/main/dialog/class_dialog.dart';
import 'package:studyhelper/modules/main/dialog/manage_dialog.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class TeacherView extends StatelessWidget {
  const TeacherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.mainColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Study Helper',
          style: GoogleFonts.alegreyaSc(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Class(),
            const SizedBox(
              height: 20,
            ),
            _Student(),
          ],
        ),
      ),
    );
  }
}

class _Class extends StatelessWidget {
  _Class({Key? key}) : super(key: key);

  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('class');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '수업 관리',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.dialog(ClassDialog());
                },
                icon: Icon(Icons.add_box_outlined)),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: classCollection
                .where('teacherId', isEqualTo: UserService.to.currentUser.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('수업이 없습니다.');
              }
              List<ClassModel> temp = RxList.empty();
              snapshot.data!.docs.forEach((e) {
                temp.add(ClassModel.fromJson(e.data() as Map<String, dynamic>));
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...temp.map((e) => _classItem(item: e)),
                ],
              );
            }),
      ],
    );
  }

  Widget _classItem({required ClassModel item}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.defaultTextColor),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.subject,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${Utils.convertDate(date: item.date)} ${(item.time ~/ 100).toString()}:${(item.time % 100).toString().padLeft(2, '0')}~${(item.time ~/ 100 + (item.duration ~/ 60)).toString()}:${(item.time % 100).toString().padLeft(2, '0')}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.defaultTextColor),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Get.dialog(ManageDialog(
                      classItem: item,
                    ));
                  },
                  child: Icon(Icons.settings))
            ],
          ),
          ...List.generate(item.studentId.length, (index) {
            return _StudentItem(uid: item.studentId[index]);
          })
        ],
      ),
    );
  }
}

class _Student extends StatelessWidget {
  const _Student({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '학생 관리',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _studentItem({required String uid}) {
    return FutureBuilder(
        future: UserService.to.getUser(uid: uid),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Text(snapshot.data!.nick);
        });
  }
}

class _StudentItem extends StatelessWidget {
  final String uid;
  _StudentItem({required this.uid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserService.to.getUser(uid: uid),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Text(snapshot.data!.nick),
                const Spacer(),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.bar_chart,
                      size: 20,
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {

                    },
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                    )),
              ],
            ),
          );
        });
  }
}
