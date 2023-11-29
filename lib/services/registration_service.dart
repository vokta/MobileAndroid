import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vokta_app/models/user.dart';

class RegistrationService {
  final baseUrl = dotenv.env['API_BASE_URL'];
  final registerStartUrl = dotenv.env['REGISTER_START_URL'];
  final validateEmailUrl = dotenv.env['VALIDATE_EMAIL_URL'];
  final storeUserUrl = dotenv.env['STORE_USER_URL'];
  final resendOtpUrl = dotenv.env['RESEND_OTP_URL'];
  final verifyOtpUrl = dotenv.env['VERIFY_OTP_URL'];
  final registerComplatedUrl = dotenv.env['REGISTER_COMPLETE_URL'];

  String? jsessionId;

  Future<bool> registrationStart() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$registerStartUrl'));
      jsessionId = response.headers['set-cookie'];
      print('$baseUrl$registerStartUrl');

      final box = GetStorage();
      box.write('jsessionid', jsessionId);

      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> isEmailAvailable(String email) async {
    final box = GetStorage();
    final jsessionId = box.read('jsessionid');
    try {
      final Uri uri = Uri.parse('$baseUrl$validateEmailUrl');

      print(uri);
      final Map<String, String> requestBody = {
        'email': email,
      };
      print(requestBody);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jsessionId ?? ''
        },
        body: json.encode(requestBody),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> storeUser(User user) async {
    final box = GetStorage();
    final jsessionId = box.read('jsessionid');
    try {
      final Uri uri = Uri.parse('$baseUrl$storeUserUrl');
      print(uri);
      final requestBody = user.toJson();
      print(requestBody);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jsessionId ?? ''
        },
        body: requestBody,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final box = GetStorage();
        box.write('userRegister', user.toJson());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getOtpCode() async {
    final box = GetStorage();
    final jsessionId = box.read('jsessionid');
    try {
      final Uri uri = Uri.parse('$baseUrl$resendOtpUrl');
      print(uri);
      final response = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'Cookie': jsessionId ?? ''
      });
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyOtpCode(String otp) async {
    final box = GetStorage();
    final jsessionId = box.read('jsessionid');
    String? userJson = box.read('userRegister');
    User user = User.fromJson(userJson!);
    try {
      final Uri uri = Uri.parse('$baseUrl$verifyOtpUrl');

      print(uri);
      final Map<String, String> requestBody = {'email': user.email, 'otp': otp};
      print(requestBody);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jsessionId ?? ''
        },
        body: json.encode(requestBody),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> registrationCompleted() async {
    final box = GetStorage();
    final jsessionId = box.read('jsessionid');
    try {
      final Uri uri = Uri.parse('$baseUrl$registerComplatedUrl');
      print(uri);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jsessionId ?? ''
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
