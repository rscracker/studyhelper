import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/modules/history/history_view_controller.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';

class HistoryView extends GetView<HistoryViewController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: const Text(
          '공부 기록',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Summary(
                  korean: controller.korean,
                  math: controller.math,
                  english: controller.english,
                  etc: controller.etc,
                  korean2: controller.korean2,
                  math2: controller.math2,
                  english2: controller.english2,
                  etc2: controller.etc2,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class Summary extends StatelessWidget {
  final int korean;
  final int math;
  final int english;
  final int etc;
  final int korean2;
  final int math2;
  final int english2;
  final int etc2;

  const Summary(
      {required this.korean,
      super.key,
      required this.math,
      required this.english,
      required this.etc,
      required this.korean2,
      required this.math2,
      required this.english2,
      required this.etc2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _studySummary(
                subject: '국어', todayTime: korean, weekTime: korean + korean2),
            _studySummary(
                subject: '수학', todayTime: math, weekTime: math + math2),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _studySummary(
                subject: '영어',
                todayTime: english,
                weekTime: english + english2),
            _studySummary(subject: '기타', todayTime: etc, weekTime: etc + etc2),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // Obx(
        //   () => Text(
        //     '최장 공부 시간 : ${(maxTime.value ~/ 3600).toString()}시간 ${((maxTime.value % 3600) ~/ 60).toString()}분',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 5,
        // ),
        // Obx(
        //   () => Text(
        //     '공부 시간 비율 : ${((total / (3600 * 24)) * 100).toStringAsFixed(2)}%',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _studySummary({
    required String subject,
    required int todayTime,
    required int weekTime,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.mainColor,
      ),
      width: Get.width / 2 - 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subject,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '오늘 : ${(todayTime ~/ 3600).toString()}시간 ${((todayTime % 3600) ~/ 60).toString().padLeft(2, '0')}분',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '이번 주 : ${(todayTime ~/ 3600).toString()}시간 ${((todayTime % 3600) ~/ 60).toString().padLeft(2, '0')}분',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
