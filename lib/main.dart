import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/screens/splash_screen_page.dart';
import 'package:flutter/services.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    home: SplashScreenPage()
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
