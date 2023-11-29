import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:vokta_app/screens/registration_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Belum Punya Akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF2C2C2C),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 84.h,
              ),
              Image.asset('assets/images/welcome2.png', width: 290.w),
              SizedBox(
                height: 80.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => RegistrationPage());
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  ),
                  child: Container(
                      width: 300.w,
                      height: 20.h,
                      child: Center(
                        child: Text(
                          'Daftar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ))),
              SizedBox(
                height: 12.h,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sudah punya akun? ',
                      style: TextStyle(
                        color: const Color(0xFF3B3B3B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Masuk',
                      style: TextStyle(
                        color: const Color(0xFF369EFF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => LoginPage());
                        },
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
