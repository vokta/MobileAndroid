import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TandonController extends GetxController {
  var tandonList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTandonList();
    super.onInit();
  }

  Future<void> fetchTandonList() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('accessToken') ?? '';

    final url = Uri.parse('http://10.0.2.2:8000/api/list-tandon');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      tandonList.value = responseData;
    } else {
      // Handle error
      print('Failed to fetch data: ${response.statusCode}');
    }

    isLoading.value = false;
  }
}