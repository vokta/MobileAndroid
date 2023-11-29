import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final baseUrl = dotenv.env['API_BASE_URL'];
  final loginUrl = dotenv.env['LOGIN_URL'];
  final logoutUrl = dotenv.env['LOGOUT_URL'];

  Future<int> login(String email, String password) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$loginUrl');
      print(uri);
      final Map<String, String> requestBody = {
        'email': email,
        'password': password
      };
      print(requestBody);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['access-token'];
        final box = GetStorage();
        box.write('isLoggedIn', true);
        box.write('accessToken', token);
      }

      return response.statusCode;
    } catch (e) {
      return 400;
    }
  }

  Future<bool> logout() async {
    try {
      final Uri uri = Uri.parse('$baseUrl$logoutUrl');

      final box = GetStorage();
      final accessToken = box.read('accessToken');

      print(uri);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final box = GetStorage();
        box.write('isLoggedIn', false);
        box.write('accessToken', null);
        box.write('user', null);
        box.write('tankList', null);
        box.write('tankEvent', null);
        box.write('selectedTank', null);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
