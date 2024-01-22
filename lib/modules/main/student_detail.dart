import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/main/student_detail_view_controller.dart';
import 'package:studyhelper/modules/main/dialog/todo_dialog.dart';
import 'package:studyhelper/modules/stopwatch/stopwatch_view.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';

class StudentDetailView extends GetView<StudentDetailViewController> {
  const StudentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.selectedUser.name),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Todo(
              student: controller.selectedUser,
              todos: controller.todos,
            ),
          ],
        ),
      ),
    );
  }
}

class _Todo extends StatelessWidget {
  final UserModel student;
  final List<TodoModel> todos;
  _Todo({required this.student, required this.todos, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const _Category(
                title: '할 일',
              ),
              ...todos.map((e) => _todoItem(todo: e)).toList(),
            ],
          ),
        ));
  }

  Widget _todoItem({required TodoModel todo}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.subject,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: Get.width - 150,
                  child: Text(
                    todo.todo,
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '소요시간 : ${todo.leadTime ~/ 3600}시간 ${(todo.leadTime - (todo.leadTime ~/ 3600) * 3600) ~/ 60}분',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.mainColor.withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const Spacer(),
          icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
