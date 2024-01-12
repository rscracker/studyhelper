import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/search_dialog.dart';
import 'package:studyhelper/modules/history/history_view.dart';
import 'package:studyhelper/modules/main/dialog/class_dialog.dart';
import 'package:studyhelper/modules/main/dialog/manage_dialog.dart';
import 'package:studyhelper/modules/main/student_detail.dart';
import 'package:studyhelper/modules/notifications/notification_view.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class ParentsView extends StatelessWidget {
  const ParentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Profile(),
              _Class(),
              const SizedBox(
                height: 20,
              ),
              _Student(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile({Key? key}) : super(key: key);

  UserService get userService => UserService.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff040C36),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Align(
                child: Text(
                  Utils.convertDate(date: DateTime.now()),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
            Text(
              userService.currentUser.name +
                  ' ' +
                  userService.currentUser.type +
                  '${userService.currentUser.type == '학부모' ? '님' : ''}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              userService.currentUser.nick,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _icon(
                    category: '학생/선생님',
                    icon: Icons.supervisor_account_rounded,
                    onPressed: () {}),
                const SizedBox(
                  width: 15,
                ),
                _icon(
                    category: '알림',
                    icon: Icons.notifications_none_outlined,
                    onPressed: () {
                      Get.to(() => NotificationView());
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(
      {required String category,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          category,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class _Class extends StatelessWidget {
  _Class({Key? key}) : super(key: key);

  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('class');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          _Category(
            title: '수업',
          ),
          StreamBuilder<QuerySnapshot>(
              stream: classCollection
                  .where('parentsId',
                      arrayContains: UserService.to.currentUser.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('수업이 없습니다.');
                }
                List<ClassModel> temp = RxList.empty();
                snapshot.data!.docs.forEach((e) {
                  temp.add(
                      ClassModel.fromJson(e.data() as Map<String, dynamic>));
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...temp.map((e) => _classItem(item: e)),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _classItem({required ClassModel item}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subject,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${Utils.convertDate(date: item.date)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${Utils.convertTime2(time: item.time)} ~ ${Utils.convertTime2(time: item.time + (item.duration))}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor,
                          fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.mainColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2),
                      child: Center(
                          child: Text(
                        '수업 전',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      )),
                    ))
              ],
            ),
            const Spacer(),
            Icon(Icons.info_outline_rounded),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class _Student extends StatelessWidget {
  const _Student({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Category(
            title: '학생 관리',
            icon: GestureDetector(
                onTap: () {
                  Get.dialog(SearchDialog());
                },
                child: Icon(
                  Icons.add_circle_outline_outlined,
                  size: 20,
                )),
          ),
          StreamBuilder(
              stream: UserService.to.getFriends(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox.shrink();
                }
                final friends = snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    ...List.generate(friends['friends'].length, (index) {
                      return _studentItem(uid: friends['friends'][index]);
                    }),
                  ],
                );
              }),
        ],
      ),
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
          UserModel student = snapshot.data!;
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${student.name} ${student.type}'),
                  Text(student.nick),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => StudentDetail(
                        student: student,
                      ));
                },
                child: Icon(
                  Icons.calendar_today_outlined,
                ),
              )
            ],
          );
        });
  }
}

class _Category extends StatelessWidget {
  final String title;
  final Widget? icon;
  const _Category({required this.title, this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const Spacer(),
          icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
