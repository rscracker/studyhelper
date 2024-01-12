import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/main/dialog/todo_dialog.dart';
import 'package:studyhelper/modules/stopwatch/stopwatch_view.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';

class StudentDetail extends StatelessWidget {
  final UserModel student;
  const StudentDetail({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Todo(
              student: student,
            ),
          ],
        ),
      ),
    );
  }
}

class _Todo extends StatelessWidget {
  final UserModel student;
  final todoService = TodoService.to;

  _Todo({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          _Category(
            title: '할 일',
          ),
          FutureBuilder(
              future: todoService.getStudentTodo(uid: student.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TodoModel>> snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty)
                  return Text('${student.name}학생의 오늘 할 일이 없습니다.');
                return Column(
                  children: [...snapshot.data!.map((e) => _todoItem(todo: e))],
                );
              })
        ],
      ),
    );
  }

  Widget _todoItem({required TodoModel todo}) {
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
            GestureDetector(
                onTap: () async {
                  await todoService.onTodoDone(todo: todo);
                },
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColor.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: !todo.isDone
                      ? SizedBox.shrink()
                      : Center(
                          child: Icon(
                          Icons.check,
                          size: 16,
                        )),
                )),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.subject,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: Get.width - 150,
                  child: Text(
                    todo.todo,
                    style: TextStyle(
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
            const Spacer(),
            Column(
              children: [
                if (!todo.isDone)
                  GestureDetector(
                    onTap: (() => Get.to(() => StopWatchView(
                          todo: todo,
                        ))),
                    child: Icon(
                      Icons.timer_outlined,
                      size: 20,
                    ),
                  ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await todoService.deteteTodo(todo: todo);
                  },
                  child: Icon(
                    Icons.delete_outline_outlined,
                    size: 20,
                  ),
                ),
              ],
            )
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
