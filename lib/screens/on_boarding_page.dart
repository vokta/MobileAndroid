import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/register_page.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/welcome.png', width: 250.w),
              SizedBox(height: 55.h),
              Text('Monitor kualitas air anda\nsecara real time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2C),
                      fontSize: 20.sp)),
              SizedBox(height: 9.h),
              Text(
                'Nikmati kemudahan hanya dalam\ngenggaman',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFB0B0B0),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(height: 61.h),
              InkWell(
                enableFeedback: false,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.to(() => RegisterPage());
                },
                child: Container(
                    width: 150.w,
                    height: 30.h,
                    child: Center(
                      child: Text(
                        'Mulai',
                        style: TextStyle(
                          color: Color(0xFF5DCCFC),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
