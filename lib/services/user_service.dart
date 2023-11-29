import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vokta_app/controllers/user_controller.dart';
import 'package:vokta_app/models/user.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/login_page.dart';

class UserService {
  final UserController _userController = Get.put(UserController());
  final baseUrl = dotenv.env['API_BASE_URL'];
  final userRetrieveUpdateUrl = dotenv.env['RETRIEVE_UPDATE_USER_URL'];
  final _userStorage = GetStorage();

  Future<User> retrieveUser(BuildContext context) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$userRetrieveUpdateUrl');
      print(uri);

      final accessToken = _userStorage.read('accessToken');

      print('accessToken: $accessToken');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);

        User user = User(
          uid: userData['uid'],
          firstname: userData['firstname'],
          lastname: userData['lastname'],
          email: userData['email'],
          mobileNo: userData['mobileNo'],
          address: userData['address'],
        );

        // _userController.setFullName(user.firstname + ' ' + user.lastname);
        // _userController.setEmail(user.email);

        _userStorage.write('user', user.toJson());

        print(user.toJson());

        return user;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      throw Exception('Failed to get user data');
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  Future<bool> updateUser(User user, BuildContext context) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$userRetrieveUpdateUrl');
      print(uri);

      final accessToken = _userStorage.read('accessToken');

      print('accessToken: $accessToken');

      final response = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: user.toJson());
      print(response.body);

      if (response.statusCode == 200) {
        _userStorage.write('user', user.toJson());

        // _userController.setFullName(user.firstname + ' ' + user.lastname);
        // _userController.setEmail(user.email);

        return true;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      return false;
    } catch (e) {
      return true;
    }
  }

  Future<void> showSessionExpiredDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Sesi Berakhir'),
          content: Text('Sesi anda telah berakhir, silahkan login ulang'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _userStorage.write('isLoggedIn', false);
                _userStorage.write('accessToken', null);
                _userStorage.write('user', null);
                _userStorage.write('tankList', null);
                _userStorage.write('tankEvent', null);
                _userStorage.write('selectedTank', null);

                Get.offAll(() => LoginPage());
              },
            ),
          ],
        );
      },
    );
  }
}
