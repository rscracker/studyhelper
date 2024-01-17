import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/modules/setting/bindings/setting_view_binding.dart';
import 'package:studyhelper/modules/setting/setting_view_controller.dart';
import 'package:studyhelper/utils/app_color.dart';

class SettingView extends GetView<SettingViewController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        text: '로그아웃', onPressed: controller.onLogOut)),
                // const SizedBox(
                //   width: 10,
                // ),
                // Expanded(child: CustomButton(text: '탈퇴하기', onPressed: () {}))
              ],
            )
          ],
        ),
      ),
    );
  }
}
