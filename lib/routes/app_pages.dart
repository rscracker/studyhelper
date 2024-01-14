import 'package:get/get.dart';
import 'package:studyhelper/modules/friends/bindings/friends_binding.dart';
import 'package:studyhelper/modules/friends/friends_view.dart';
import 'package:studyhelper/modules/history/history_view.dart';
import 'package:studyhelper/modules/main/bindings/main_binding.dart';
import 'package:studyhelper/modules/main/bindings/student_detail_binding.dart';
import 'package:studyhelper/modules/main/main_controller.dart';
import 'package:studyhelper/modules/main/main_view.dart';
import 'package:studyhelper/modules/main/student_detail.dart';
import 'package:studyhelper/modules/notifications/bindings/notification_binding.dart';
import 'package:studyhelper/modules/notifications/notification_view.dart';
import 'package:studyhelper/modules/parents/bindings/parents_binding.dart';
import 'package:studyhelper/modules/parents/parents_view.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: '/main', page: () => const MainView(), bindings: [
      MainBinding(),
    ]),
    GetPage(
        name: '/friends',
        page: () => const FriendsView(),
        binding: FriendsBinding()),
    GetPage(name: '/history', page: () => HistoryView()),
    GetPage(
        name: '/notification',
        page: () => NotificationView(),
        binding: NotificationBinding()),
    GetPage(
        name: '/parents',
        page: () => const ParentsView(),
        binding: ParentsBinding()),
    GetPage(
        name: '/studentDetail',
        page: () => const StudentDetailView(),
        binding: StudnetDetailBinding())
  ];
}
