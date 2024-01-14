import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/parents/parents_controller.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/modules/common/search_dialog.dart';
import 'package:studyhelper/modules/main/student_detail.dart';
import 'package:studyhelper/modules/notifications/notification_view.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class ParentsView extends GetView<ParentsController> {
  const ParentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Profile(
                user: controller.currentUser,
                onPressedNotification: controller.onPressedNotification,
              ),
              _Class(classes: controller.classes),
              const SizedBox(
                height: 20,
              ),
              _Student(
                nameController: controller.nameController,
                nickController: controller.nickController,
                onSearch: controller.onSearch,
                currentUser: controller.currentUser,
                friends: controller.friends,
                onPressedStudentDetail: controller.onPressedStudentDetail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onPressedNotification;
  const _Profile(
      {required this.user, required this.onPressedNotification, Key? key})
      : super(key: key);

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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name} 학부모님',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      user.nick,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onPressedNotification,
                  child: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
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
          style: const TextStyle(
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
  final List<ClassModel> classes;
  _Class({required this.classes, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const _Category(
                title: '수업',
              ),
              if (classes.isEmpty) const Text('수업이 없습니다.'),
              if (classes.isNotEmpty)
                ...classes.map((e) => _classItem(item: e)).toList()
            ],
          ),
        ));
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
  final TextEditingController nameController;
  final TextEditingController nickController;
  final Function({required bool isNick}) onSearch;
  final List<UserModel> friends;
  final UserModel currentUser;
  final Function({required UserModel user}) onPressedStudentDetail;
  const _Student(
      {required this.nameController,
      required this.nickController,
      required this.onSearch,
      required this.friends,
      required this.currentUser,
      required this.onPressedStudentDetail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Category(
                title: '학생 관리',
                icon: GestureDetector(
                    onTap: () {
                      Get.dialog(SearchDialog(
                        nickController: nickController,
                        nameController: nameController,
                        onSearch: onSearch,
                      ));
                    },
                    child: const Icon(
                      Icons.add_circle_outline_outlined,
                      size: 20,
                    )),
              ),
              if (friends.isNotEmpty)
                ...friends.map((e) => _studentItem(user: e)).toList()
            ],
          ),
        ));
  }

  Widget _studentItem({required UserModel user}) {
    return GestureDetector(
      onTap: () => onPressedStudentDetail(user: user),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 45,
        decoration: BoxDecoration(
          color: AppColor.mainColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${user.nick} ${user.type}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const Spacer(),
          icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
