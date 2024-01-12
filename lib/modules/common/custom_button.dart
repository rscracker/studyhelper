import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final double? borderRadius;
  const CustomButton(
      {required this.text,
      required this.onPressed,
      this.height,
      this.width,
      this.borderColor,
      this.buttonColor,
      this.textColor,
      this.borderRadius,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.white,
          border:
              Border.all(width: 1, color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}
