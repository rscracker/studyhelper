import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/common/custom_dialog.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/utils/app_color.dart';

class StopWatchView extends StatefulWidget {
  final TodoModel todo;
  const StopWatchView({required this.todo, Key? key}) : super(key: key);

  @override
  State<StopWatchView> createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  late final Stopwatch stopwatch;
  late Timer t;
  final todoService = TodoService.to;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  String returnFormattedText() {
    var sec = stopwatch.elapsed.inSeconds;

    String seconds =
        (sec % 60).toString().padLeft(2, '0'); // this is for the second
    String minutes =
        (sec ~/ 60).toString().padLeft(2, "0"); // this is for the minute
    String hours = (sec ~/ 3600).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    t.cancel();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          '시간 측정',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.todo.subject,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.todo.todo,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape
                    .circle, // this one is use for make the circle on ui.
                border: Border.all(
                  color: AppColor.mainColor,
                  width: 4,
                ),
              ),
              child: Text(
                returnFormattedText(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              buttonColor: AppColor.mainColor,
              height: 50,
              text: stopwatch.isRunning ? '측정 종료' : '측정 시작',
              onPressed: () {
                if (stopwatch.isRunning) {
                  Get.dialog(CustomDialog(
                      text: '측정이 종료되었습니다.\n\n 공부시간 : ${returnFormattedText()}',
                      onPressed: () async {
                        t.cancel();
                        handleStartStop();
                        Get.close(2);
                        await todoService.timeCheck(
                            todo: widget.todo,
                            time: stopwatch.elapsed.inSeconds);
                      }));
                } else {
                  handleStartStop();
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
