import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/splash_screen_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await dotenv.load(fileName: ".env.lab");
  await GetStorage.init();

  runApp(const VoktaApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class VoktaApp extends StatelessWidget {
  const VoktaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenPage(),
        );
      },
    );
  }
}
