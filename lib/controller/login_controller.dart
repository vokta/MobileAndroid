import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:vokta_app/model/user.dart';
import 'package:vokta_app/response/login_response.dart';
import 'package:vokta_app/screens/home.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    // Replace "http://localhost:8000" with your API endpoint URL
    final url = Uri.parse('http://10.0.2.2:8000/api/login');

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final responseData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseData);

        final now = DateTime.now();

        prefs.setBool('hasSession', true);
        prefs.setString('lastLoginTime', now.toIso8601String());
        prefs.setString('accessToken', loginResponse.accessToken);
        prefs.setInt('id', loginResponse.user.id);
        prefs.setString('email', loginResponse.user.email);
        prefs.setString('name', loginResponse.user.name);

        Get.offAll(Home());
      } else {
        handleError(response.body.toString());
      }
    } catch (error) {
      handleError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

void handleError(String errorMessage) {
  Get.snackbar(
    'Error',
    errorMessage,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
  print('Error: $errorMessage');
}

class UserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    // Cek apakah ada session user yang tersimpan saat aplikasi dibuka
    final storage = GetStorage();
    final userJson = storage.read('user');
    if (userJson != null) {
      user.value = User.fromJson(userJson);
    }

    super.onInit();
  }
}

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  String? get accessToken => GetStorage().read('accessToken');
}
