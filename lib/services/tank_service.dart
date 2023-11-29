import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vokta_app/models/tank.dart';
import 'package:vokta_app/models/tank_brand.dart';
import 'package:vokta_app/models/tank_event_response.dart';
import 'package:vokta_app/models/tank_type.dart';
import 'package:vokta_app/screens/login_page.dart';

class TankService {
  final baseUrl = dotenv.env['API_BASE_URL'];
  final listTankBrandUrl = dotenv.env['TANK_BRAND_LIST_URL'];
  final listTankTypedUrl = dotenv.env['TANK_BRAND_TYPE_URL'];
  final manageTankUrl = dotenv.env['MANAGE_TANK_URL'];

  final _tankStorage = GetStorage();

  Future<List<TankBrand>> tankBrandList() async {
    try {
      final Uri uri = Uri.parse('$baseUrl$listTankBrandUrl');
      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      List<TankBrand> result = [];

      if (response.statusCode == 200) {
        List<dynamic> tankList = json.decode(response.body);
        for (var tank in tankList) {
          if (tank['uid'] != null && tank['name'] != null) {
            TankBrand tankBrand =
                TankBrand(uid: tank['uid'], name: tank['name']);
            result.add(tankBrand);
          }
        }
      }
      print(result.length);

      return result;
    } catch (e) {
      throw Exception('Failed to get tank brand data: $e');
    }
  }

  Future<List<TankType>> tankTypeList(String brandUid) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$listTankTypedUrl$brandUid');
      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      List<TankType> result = [];

      if (response.statusCode == 200) {
        List<dynamic> tankList = json.decode(response.body);
        for (var tank in tankList) {
          if (tank['uid'] != null &&
              tank['name'] != null &&
              tank['capacity'] != null &&
              tank['diameter'] != null &&
              tank['height'] != null) {
            TankType tankBrand = TankType(
                uid: tank['uid'],
                name: tank['name'],
                capacity: tank['capacity'],
                diameter: tank['diameter'],
                height: tank['height']);
            result.add(tankBrand);
          }
        }
      }
      print(result.length);

      return result;
    } catch (e) {
      throw Exception('Failed to get tank type data: $e');
    }
  }

  Future<bool> addTank(Tank tank, BuildContext context) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);
      print(tank.toJson());

      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: tank.toJson());
      print(response.body);

      bool result = false;

      if (response.statusCode == 200) {
        result = true;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      return result;
    } catch (e) {
      throw Exception('Failed to get add tank: $e');
    }
  }

  Future<bool> updateTank(Tank tank, BuildContext context) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);
      print(tank.toJson());

      final response = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: tank.toJson());
      print(response.body);

      bool result = false;

      if (response.statusCode == 200) {
        result = true;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      return result;
    } catch (e) {
      throw Exception('Failed to update tank: $e');
    }
  }

  Future<List<Tank>> list(BuildContext context) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      List<Tank> result = [];

      if (response.statusCode == 200) {
        final List<dynamic>? items = json.decode(response.body)['items'];

        if (items != null) {
          result = items
              .map((item) => Tank(
                    uid: item['uid'],
                    sensorId: item['sensorId'],
                    sensorName: item['sensorName'],
                    capacity: item['capacity'],
                  ))
              .toList();
        }

        print(result.length.toString());
        print(jsonEncode(result));

        _tankStorage.write('tankList', jsonEncode(result));

        return result;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      return result;
    } catch (e) {
      throw Exception('Failed to get tank type data: $e');
    }
  }

  Future<bool> delete(BuildContext context, String uid) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl?uid=$uid');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);

      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      bool result = false;

      if (response.statusCode == 200) {
        result = true;
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      return result;
    } catch (e) {
      throw Exception('Failed to get tank type data: $e');
    }
  }

  Future<Tank> detail(BuildContext context, String uid) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl/$uid');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      Tank result = Tank();

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null) {
          final Map<String, dynamic>? microcontroller =
              responseData['microcontroller'];

          if (microcontroller != null) {
            result = Tank(
              uid: microcontroller['uid'],
              sensorId: microcontroller['sensorId'],
              sensorName: microcontroller['sensorName'],
              tankBrand: microcontroller['tankBrand'],
              tankType: microcontroller['tankType'],
              capacity: microcontroller['capacity'],
              diameter: microcontroller['diameter'],
              height: microcontroller['height'],
            );
          }
        }
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      print(result.toJson());

      return result;
    } catch (e) {
      throw Exception('Failed to get tank type data: $e');
    }
  }

  Future<TankEventResponse> event(BuildContext context, String uid) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$manageTankUrl/events/$uid');
      final accessToken = _tankStorage.read('accessToken');
      print(uri);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.body);

      TankEventResponse result = TankEventResponse();

      if (response.statusCode == 200) {
        result = TankEventResponse.fromJson(response.body);
      } else if (response.statusCode == 401) {
        await showSessionExpiredDialog(context);
      }

      _tankStorage.write('tankEvent', result.toJson());

      print(result.toJson());

      return result;
    } catch (e) {
      throw Exception('Failed to get tank type data: $e');
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
                _tankStorage.write('isLoggedIn', false);
                _tankStorage.write('accessToken', null);
                _tankStorage.write('user', null);
                _tankStorage.write('tankList', null);
                _tankStorage.write('tankEvent', null);
                _tankStorage.write('selectedTank', null);
                Get.offAll(() => LoginPage());
              },
            ),
          ],
        );
      },
    );
  }
}
