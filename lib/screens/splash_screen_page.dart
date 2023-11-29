import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/screens/home.dart';
import 'package:vokta_app/screens/on_boarding_page.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF67D0FD), Color(0xFFDFF5FF)],
            ),
          ),
          child: Stack(children: [
            Positioned(
              bottom: -15.h,
              left: -50.w,
              child: Center(
                child: Image.asset(
                  'assets/images/wave.png',
                  width: 600.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              child: SplashContent(),
            ),
          ])),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  double opacityLevel = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1;
      });

      final box = GetStorage();
      final isLoggedIn = box.read('isLoggedIn') ?? false;

      Future.delayed(const Duration(seconds: 2), () {
        isLoggedIn
            ? Get.offAll(() => Home())
            : Get.offAll(() => OnBoardingPage());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: opacityLevel,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
        child: Column(
          children: [
            SizedBox(height: 200.h),
            Image.asset(
              'assets/images/vokta_logo.png',
              width: 180.w,
            ),
            SizedBox(height: 300.h),
            Text(
              'Powered by Vokasi Water',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
