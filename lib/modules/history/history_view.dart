import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:studyhelper/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryView extends StatelessWidget {
  HistoryView({Key? key}) : super(key: key);

  final todoService = TodoService.to;

  TooltipBehavior _toolTip = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text('공부 기록'),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
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
              Summary(),
            ],
          ),
        ),
      )),
    );
  }
}

class Summary extends StatefulWidget {
  Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  final todoService = TodoService.to;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _studySummary(
                    subject: '국어',
                    todayTime: todoService.korean,
                    weekTime: todoService.korean + todoService.korean2),
                _studySummary(
                    subject: '수학',
                    todayTime: todoService.math,
                    weekTime: todoService.math + todoService.math2),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _studySummary(
                  subject: '영어',
                  todayTime: todoService.english,
                  weekTime: todoService.english + todoService.english2),
              _studySummary(
                  subject: '기타',
                  todayTime: todoService.etc,
                  weekTime: todoService.etc + todoService.etc2),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => Text(
            '최장 공부 시간 : ${(todoService.maxTime.value ~/ 3600).toString()}시간 ${((todoService.maxTime.value % 3600) ~/ 60).toString()}분',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => Text(
            '공부 시간 비율 : ${((todoService.total / (3600 * 24)) * 100).toStringAsFixed(2)}%',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '오늘 : ${(todayTime ~/ 3600).toString()}시간 ${((todayTime % 3600) ~/ 60).toString().padLeft(2, '0')}분',
              style: TextStyle(
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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // CustomButton(
            //   text: '오답 노트',
            //   buttonColor: AppColor.mainColor,
            //   textColor: Colors.white,
            //   onPressed: () {},
            //   height: 35,
            //   borderColor: Colors.white,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CustomButton(
            //   text: '약점 분석',
            //   buttonColor: AppColor.mainColor,
            //   textColor: Colors.white,
            //   onPressed: () {},
            //   height: 35,
            //   borderColor: Colors.white,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CustomButton(
            //   text: '메모',
            //   buttonColor: AppColor.mainColor,
            //   textColor: Colors.white,
            //   onPressed: () {},
            //   height: 35,
            //   borderColor: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
