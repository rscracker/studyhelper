import 'package:flutter/material.dart';
import 'package:studyhelper/modules/common/custom_button.dart';
import 'package:studyhelper/utils/app_color.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomDialog({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '알림',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: TextStyle(),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
            height: 50,
            text: '확인',
            onPressed: onPressed,
            buttonColor: AppColor.mainColor,
          )
        ],
      ),
    );
  }
}
