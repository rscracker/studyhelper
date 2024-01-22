import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/modules/schedule/scheuld_view_controller.dart';
import 'package:studyhelper/utils/app_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleView extends GetView<ScheduleViewController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '일정',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColor.mainColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.mainColor,
          onPressed: () {},
          child: const Center(
              child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SfCalendar(
                view: CalendarView.month,
              ),
            ],
          ),
        ));
  }
}
