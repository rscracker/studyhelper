import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/modules/main/main_controller.dart';
import 'package:studyhelper/modules/history/history_view.dart';
import 'package:studyhelper/modules/main/dialog/todo_dialog.dart';
import 'package:studyhelper/modules/notifications/notification_view.dart';
import 'package:studyhelper/modules/schedule/schedule_view.dart';
import 'package:studyhelper/modules/stopwatch/stopwatch_view.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Profile(
              name: controller.currentUser.name,
              nick: controller.currentUser.nick,
              onPressedSetting: controller.onPressedSetting,
            ),
            _Class(
              classes: controller.classes,
            ),
            _Todo(
              todos: controller.todos,
              onTodoDone: controller.onTodoDone,
              onDeleteTodo: controller.onDeleteTodo,
            )
          ],
        )),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  final String name;
  final String nick;
  final VoidCallback onPressedSetting;

  const _Profile(
      {required this.name,
      required this.nick,
      required this.onPressedSetting,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                GestureDetector(
                  onTap: onPressedSetting,
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              nick,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _icon(
                    category: '공부 기록',
                    icon: Icons.insert_chart_outlined,
                    onPressed: () {
                      Get.toNamed('/history');
                    }),
                _icon(
                    category: '일정',
                    icon: Icons.calendar_today_outlined,
                    onPressed: () {
                      Get.to(() => ScheduleView());
                    }),
                _icon(
                    category: '친구',
                    icon: Icons.supervisor_account_rounded,
                    onPressed: () {
                      Get.toNamed('/friends');
                    }),
                _icon(
                    category: '알림',
                    icon: Icons.notifications_none_outlined,
                    onPressed: () {
                      Get.toNamed('/notification');
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

class _Todo extends StatelessWidget {
  final List<TodoModel> todos;
  final void Function(TodoModel todo) onTodoDone;
  final void Function(TodoModel todo) onDeleteTodo;

  const _Todo(
      {required this.todos,
      required this.onTodoDone,
      required this.onDeleteTodo,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              _Category(
                title: '해야할 일',
                icon: GestureDetector(
                    onTap: () {
                      Get.dialog(TodoDialog());
                    },
                    child: const Icon(
                      Icons.add_circle_outline_outlined,
                      size: 22,
                    )),
              ),
              if (todos.isEmpty) const Text('오늘 할 일이 없습니다.'),
              if (todos.isNotEmpty)
                ...todos.map((e) => _todoItem(
                    todo: e,
                    onTodoDone: onTodoDone,
                    onDeleteTodo: onDeleteTodo)),
            ],
          ),
        ));
  }

  Widget _todoItem({
    required TodoModel todo,
    required void Function(TodoModel todo) onTodoDone,
    required void Function(TodoModel todo) onDeleteTodo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                onTap: () => onTodoDone(todo),
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
                      ? const SizedBox.shrink()
                      : const Center(
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
            const Spacer(),
            Column(
              children: [
                if (!todo.isDone)
                  GestureDetector(
                    onTap: (() => Get.to(() => StopWatchView(
                          todo: todo,
                        ))),
                    child: const Icon(
                      Icons.timer_outlined,
                      size: 20,
                    ),
                  ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => onDeleteTodo(todo),
                  child: const Icon(
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

class _Class extends StatelessWidget {
  final List<ClassModel> classes;
  const _Class({required this.classes, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...classes.map((e) => _classItem(item: e)),
                  ],
                )
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
                  style: const TextStyle(
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
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      Utils.convertDate(date: item.date),
                      style: const TextStyle(
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
                    const Icon(
                      Icons.timer_outlined,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${Utils.convertTime2(time: item.time)} ~ ${Utils.convertTime2(time: item.time + (item.duration))}',
                      style: const TextStyle(
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
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
            const Icon(Icons.info_outline_rounded),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
