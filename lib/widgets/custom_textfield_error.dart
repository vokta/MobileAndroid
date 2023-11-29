import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldError extends StatelessWidget {
  final String message;
  const CustomTextFieldError(
      {super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 12.sp),
        textAlign: TextAlign.left,
      ),
    );
  }
}
